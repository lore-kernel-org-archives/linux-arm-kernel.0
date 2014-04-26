From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Apr 2014 18:16:52 +0200
Subject: [PATCH 0/2] ARM: sunxi: Split Kconfig entries
Message-ID: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch adds a few Kconfig option for all the supported Allwinner
SoCs family.

Hopefully, this will reduce the size of the kernel images when we're
interested in only or a few of these family, but not all of them.

Maxime Ripard (2):
  ARM: sunxi: Split the various SoCs support in Kconfig
  ARM: Enable the new Allwinner SoCs support options

 arch/arm/configs/multi_v7_defconfig |  6 ++++++
 arch/arm/configs/sunxi_defconfig    |  5 +++++
 arch/arm/mach-sunxi/Kconfig         | 35 +++++++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
1.9.1
