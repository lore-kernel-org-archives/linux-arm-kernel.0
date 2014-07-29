From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 16:24:30 -0700
Subject: [PATCH 0/3] Enable EHCI port on rk3288-evb
Message-ID: <1406676273-20701-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the EHCI port on the rk3288-evb boards.  A later
patch series (from Kever) will enable the dwc2 ports.


Doug Anderson (3):
  ARM: dts: Turn on USB host vbus on rk3288-evb
  ARM: dts: add rk3288 ehci usb devices
  ARM: dts: Enable USB host0 (EHCI) on rk3288-evb

 arch/arm/boot/dts/rk3288-evb.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.0.0.526.g5318336
