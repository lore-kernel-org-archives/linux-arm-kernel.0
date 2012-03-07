From: sjg@chromium.org (Simon Glass)
Date: Tue,  6 Mar 2012 21:04:31 -0800
Subject: [RESEND PATCH 0/3] arm: tegra: dts: USB Updates for Tegra legacy mode
 / OTG
Message-ID: <1331096674-8324-1-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This little series brings in some bindings that seem useful for U-Boot.

I am working mostly in U-Boot, but since there is no shared .dts repo
I was asked to commit these changes to the kernel. I do not propose to
update the Linux USB drivers to match.


Simon Glass (3):
  arm: tegra: dts: Support host/device selection and legacy mode
  arm: tegra: dts: Add legacy mode support to Tegra2x USB1 port
  arm: tegra: dts: Mark USB1 as an OTG port on Seaboard

 .../devicetree/bindings/usb/tegra-usb.txt          |   13 +++++++++++++
 arch/arm/boot/dts/tegra-seaboard.dts               |    1 +
 arch/arm/boot/dts/tegra20.dtsi                     |    1 +
 3 files changed, 15 insertions(+), 0 deletions(-)

-- 
1.7.7.3
