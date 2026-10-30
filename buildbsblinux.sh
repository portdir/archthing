#!/bin/bash
setups(){
    cd ~
    mkdir -p ~/vrbuilding/
    rm -rf ~/vrbuilding/*
    cd ~/vrbuilding/
};
cleanup(){
    echo -e "\n[STOPPING]"
    kill -- -$$ 2>/dev/null || true &
    exit 1
};
SeeDependency(){
    dependencyvr="
        meson
        base-devel
        cmake
        libxkbcommon
        fontconfig
        dbus
        alsa-lib
        python3
        wayland
        dav1d
        openvr
        vulkan-headers
        shaderc
        jq
        devtools
        pacman-contrib
    "
    pacman -S --needed $dependencyvr --noconfirm
};
envision(){
    git clone https://gitlab.com/gabmus/envision.git
    cd envision
    meson setup build-aux/ 
    meson compile -C build-aux/
    meson install -C build-aux/
    cd ~/vrbuilding/
    
}
wayvr(){
    wayvrF=~/vrbuilding/wayvr
    buildwayvr(){
        git clone https://github.com/wayvr-org/wayvr.git
        cd $wayvrF
        cargo build --release --no-default-features --features=wayland,openxr,openvr,pipewire,osc,pipewire,whisper,feat-monado-metrics,as-raw-xcb-connection
        cd $wayvrF/wayvrctl
        cargo build --release
    };  
    installwayvr(){
        cd $wayvrF
        sudo install -Dm0755 -t "/usr/bin/" "target/release/wayvr"
        sudo install -Dm0755 -t "/usr/bin/" "target/release/wayvrctl"
        sudo install -Dm0644 -t "/usr/share/applications/" "wayvr/wayvr.desktop"
        sudo install -Dm0644 -t "/usr/share/icons/hicolor/128x128/apps/" "wayvr/wayvr.png"
        sudo install -Dm0644 -t "/usr/share/icons/hicolor/scalable/apps/" "wayvr/wayvr.svg"
    };
    buildwayvr
    installwayvr
    cd ~/vrbuilding/
};
fucksteamvr(){
    jq ".power.autoLaunchSteamVROnButtonPress = false" ~/.steam/root/config/steamvr.vrsettings > /tmp/steamvr.vrsettings 
    mv /tmp/steamvr.vrsettings ~/.steam/root/config/steamvr.vrsettings
};
bsbkernal(){
    pkgctl repo clone --protocol=https linux
    cd linux
    sed --in-place 's/pkgbase=linux/pkgbase=linux-bsb/g' PKGBUILD &
    sed --in-place '/source=(/ { N;N;s/$/\n  https:\/\/vronlinux.org\/docs\/hardware\/bigscreen-beyond\/bigscreen-beyond-kernel.patch/;}' PKGBUILD &
    updpkgsums
    MAKEFLAGS="--jobs=$(nproc)" makepkg -sir --skippgpcheck
}
building(){
    setups
    SeeDependency
    envision
    wayvr
    fucksteamvr
    bsbkernal
    cleanup
}
building
exit 1