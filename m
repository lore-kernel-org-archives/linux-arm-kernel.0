From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2016 12:26:48 +0100
Subject: [PATCH 0/3] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
Message-ID: <20160713112651.14539-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not a lot to it really.  The idea is to save lines.

Lee Jones (3):
  mfd: Provide MACRO to declare commonly defined MFD cell attributes
  mfd: ab8500: Example using new OF_MFD_CELL MACRO
  mfd: db8500-prcmu: Example using new OF_MFD_CELL/MFD_CELL_BASIC MACROs

 drivers/mfd/ab8500-core.c  | 138 ++++++++++++++-------------------------------
 drivers/mfd/db8500-prcmu.c |  33 ++++-------
 include/linux/mfd/core.h   |  29 ++++++++++
 3 files changed, 81 insertions(+), 119 deletions(-)

-- 
2.9.0
