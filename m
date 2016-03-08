From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:03:56 +0100
Subject: [PATCHv2 0/8] ARM: dts: update Ka-Ro i.MX6 module support
Message-ID: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set updates the Ka-Ro electronics i.MX6 based module
support and adds support for some new modules and a new baseboard.

changes vs. v1:
- relicense DTS files under GPLv2/X11
- dropped patches which have been applied already
- added some cleanup patches

[PATCHv2 1/8] ARM: dts: imx6-tx6: Relicense the Ka-Ro DT files under GPLv2/X11
[PATCHv2 2/8] ARM: dts: imx6-tx6: cleanup; no functional change
[PATCHv2 3/8] ARM: dts: imx6-tx6: remove regulator bus
[PATCHv2 4/8] ARM: dts: imx6-tx6: disable the spi node by default
[PATCHv2 5/8] ARM: dts: imx6-tx6: remove container node around pinctrl nodes
[PATCHv2 6/8] ARM: dts: imx6qdl-tx6: add mdio node for ethernet phy
[PATCHv2 7/8] ARM: dts: imx6: add support for more Ka-Ro electronics modules
[PATCHv2 8/8] ARM: dts: imx6: add support for the Ka-Ro electronics 'MB7' baseboard
