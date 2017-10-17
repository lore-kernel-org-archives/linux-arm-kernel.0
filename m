From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 10:53:22 +0200
Subject: [PATCHv2 00/12] ARM: dts: imx6: Update dts files for the Ka-Ro TX6
 module series
Message-ID: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the dts files for the Ka-Ro electronics GmbH TX6
module series and adds some include files to facilitate supporting
various SoM/baseboard combinations.

Changes vs. v1:
- rebased to imx/dt branch
- eliminate use of 'interrupts-extended' property according to Uwe
  Kleine-K?nig's comment
