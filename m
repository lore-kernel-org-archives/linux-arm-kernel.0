From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 23 Oct 2013 12:32:18 +0300
Subject: [PATCH 0/2] ARM: dts: omap5-uevm: Audio related fixes
Message-ID: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When the omap5-evm.dts file has been renamed to omap5-uevm.dts and the sEVM
support got deprecated in favor of uEVM (or Panda5) the content was not
validated.
The reset GPIO is different on uEVM compared to sEVM and uEVM does not have
support for dmic.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
  ARM: dts: omap5-uevm: Remove pinmux for dmic pins

 arch/arm/boot/dts/omap5-uevm.dts | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

-- 
1.8.4
