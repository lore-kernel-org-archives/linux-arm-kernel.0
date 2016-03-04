From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri,  4 Mar 2016 13:37:21 +0100
Subject: ARM: dts: imx6ul: add more functionality to i.MX6UL
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>,
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457095043-14115-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCHv3 1/2] ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL modules
[PATCHv3 2/2] ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL mainboard

This patchset adds more functionality to the i.MX6UL machines.

Changes vs. v1:
- added patch to implement KPP clock for i.MX6UL to prevent conflicts
  when this patch would go via a different tree.
- added board support for Ka-Ro electronics TX6UL module for the same
  reason
- added imx6ul specific compatibles as requested by Lucas Stach

Changes vs. v2:
- dropped patches which have already been applied in the meantime
- addressed comments by Shawn Guo
