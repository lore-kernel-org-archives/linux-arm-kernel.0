From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Jul 2014 13:00:09 -0700
Subject: [PATCH v2 0/3] Enable EHCI port on rk3288-evb
Message-ID: <1406750412-15592-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the EHCI port on the rk3288-evb boards.  A later
patch series (from Kever) will enable the dwc2 ports.

Changes in v2:
- usb_host_vbus => vcc_host to match supply name, not pin name.
- pin name now matches in name in schematic
- Kever is now the author
- Node is now named usb

Doug Anderson (2):
  ARM: dts: Turn on USB host vbus on rk3288-evb
  ARM: dts: Enable USB host0 (EHCI) on rk3288-evb

Kever Yang (1):
  ARM: dts: add rk3288 ehci usb devices

 arch/arm/boot/dts/rk3288-evb.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.0.0.526.g5318336
