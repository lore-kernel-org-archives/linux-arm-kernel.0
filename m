From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Jan 2017 04:06:09 +0100
Subject: [PATCH 0/2] ARM64: meson-gxm: R-Box Pro enablement
Message-ID: <20170117030611.23827-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Amlogic S912 based
R-Box Pro TV boxes.

Patch 1 should apply today, patch 2 depends on Martin's Bluetooth series.

Wifi further depends on: https://patchwork.kernel.org/patch/9518447/
(and /etc/wifi/AP6255/nvram.txt as /lib/firmware/brcm/brcmfmac43455-sdio.txt)

Regards,
Andreas

Cc: devicetree at vger.kernel.org

Andreas F?rber (2):
  ARM64: dts: meson-gxm: Add R-Box Pro
  ARM64: dts: meson-gxm-rbox-pro: Enable Bluetooth

 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 249 +++++++++++++++++++++
 2 files changed, 250 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts

-- 
2.10.2
