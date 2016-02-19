From: j-keerthy@ti.com (Keerthy)
Date: Fri, 19 Feb 2016 10:08:53 +0530
Subject: [PATCH v2 0/2] arm: am43xx: Register rtc hwmod
Message-ID: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds rtc hwmod. This is present on gp and sk evm and not on
epos evm. Hence adding it selectively using a seprate list.

Boot tested on AM437X-GP-EVM and AM437X-SK-EVM and checked
for rtc ticking on AM437X-GP-EVM.

Keerthy (2):
  ARM: dts: am43x-epos-evm: Add the am438 compatible string
  ARM: AM43XX: HWMOD: Add rtc hwmod

 Documentation/devicetree/bindings/arm/omap/omap.txt |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts                |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c          | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
1.9.1
