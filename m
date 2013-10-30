From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Oct 2013 17:55:08 +0100
Subject: [PATCH 0/2] Add support for OpenBlocks A7
Message-ID: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marvell EBU maintainers,

The small set of patches that follow add the support for the new
OpenBlocks A7 platform designed and sold by Plathome.

Best regards,

Thomas

Thomas Petazzoni (2):
  ARM: kirkwood: add support for OpenBlocks A7 platform
  ARM: kirkwood: enable HIGHMEM in defconfig

 arch/arm/boot/dts/Makefile                   |   3 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 223 +++++++++++++++++++++++++++
 arch/arm/configs/kirkwood_defconfig          |   1 +
 3 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a7.dts

-- 
1.8.1.2
