From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 23:23:45 +0200
Subject: [PATCH 0/3] arm64: dts: rockchip: add io-domain support for rk3368
 and rk3399
Message-ID: <1463865828-14583-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the core io-domain nodes for both the rk3368 and rk3399
as well as the actual supplies on the rk3368-r88 board.

This of course needs
    PM / AVS: rockchip-io: make io-domains a child of the GRF
that went into mainline during the 4.7 merge window.

Heiko Stuebner (3):
  arm64: dts: rockchip: add rk3368 io-domain core nodes
  arm64: dts: rockchip: add rk3368-r88 iodomains
  arm64: dts: rockchip: add rk3399 io-domain core nodes

 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi    | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 10 ++++++++++
 3 files changed, 36 insertions(+)

-- 
2.6.4
