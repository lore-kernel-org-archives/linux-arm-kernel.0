From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:57:00 +0100
Subject: [PATCH 0/6] ARM: dts: update Ka-Ro i.MX6 module support
Message-ID: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set updates the Ka-Ro electronics i.MX6 based module
support and adds support for some new modules and a new baseboard.

dma: enable mxs-dma for imx6ul
ARM: dts: imx6: use correct mclk frequency for audio
ARM: dts: imx6qdl-tx6: add ENET_OUT clock to fec node
ARM: dts: imx6: change TX6 module names due to new HW
ARM: dts: imx6: add support for more Ka-Ro electronics
ARM: dts: imx6: add support for the Ka-Ro electronics
