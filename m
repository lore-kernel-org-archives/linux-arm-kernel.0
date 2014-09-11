From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:56:55 +0200
Subject: [PATCH 0/4] ARM: mvebu: minor Armada 370 RD improvements
Message-ID: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

Here are four small patches to make minor improvements to the support
of the Armada 370 RD platform.

Thanks,

Thomas

Thomas Petazzoni (4):
  ARM: mvebu: add gpio fan support to Armada 370 RD
  ARM: mvebu: add user LED support of Armada 370 RD
  ARM: mvebu: add LED class support built-in in mvebu_v7_defconfig
  ARM: mvebu: add gpio-fan to mvebu_v7_defconfig

 arch/arm/boot/dts/armada-370-rd.dts | 32 ++++++++++++++++++++++++++++++++
 arch/arm/configs/mvebu_v7_defconfig |  3 ++-
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.0.0
