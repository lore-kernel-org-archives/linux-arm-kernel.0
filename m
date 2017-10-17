From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:51 +0200
Subject: [PATCHv3 00/12] ARM: dts: imx6: Update dts files for the Ka-Ro TX6
 module series
In-Reply-To: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore the V2 series. I accidentally sent the patches from a
wrong directory.

This patchset updates the dts files for the Ka-Ro electronics GmbH TX6
module series and adds some include files to facilitate supporting
various SoM/baseboard combinations.

Changes vs. v2:
- resent the correct patches

Changes vs. v1:
- rebased to imx/dt branch
- eliminate use of 'interrupts-extended' property according to Uwe
  Kleine-K?nig's comment
