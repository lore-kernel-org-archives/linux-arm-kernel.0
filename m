From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 24 Apr 2018 10:15:26 +0200
Subject: [PATCH 0/2] ARM: Update  multi_v7_defconfig and add add Marvel NAND
Message-ID: <20180424081528.25883-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While adding Marvel NAND controller support in to the
multi_v7_defconfig, I noticed that this file had greatly diverged, so
the first patch updates it.

Maybe this first patch should be merged in the current rc to reduce
the number of merge conflict.

Gregpry

Gregory CLEMENT (2):
  ARM: multi_v7_defconfig: Update with current configuration
  ARM: multi_v7_defconfig: Add Marvel NAND controller support

 arch/arm/configs/multi_v7_defconfig | 369 +++++++++++++++---------------------
 1 file changed, 153 insertions(+), 216 deletions(-)

-- 
2.16.3
