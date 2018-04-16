From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 13:56:24 +0100
Subject: [PATCH v2 0/3] mfd: Provide MACRO to declare commonly defined MFD
 cell attributes
Message-ID: <20180416125627.22156-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not a lot to it really.  The idea is to save lines.

Lee Jones (3):
  mfd: Provide MACRO to declare commonly defined MFD cell attributes
  mfd: ab8500: Example using new OF_MFD_CELL MACRO
  mfd: db8500-prcmu: Example using new OF_MFD_CELL/MFD_CELL_BASIC MACROs

 drivers/mfd/ab8500-core.c  | 138 ++++++++++++++-------------------------------
 drivers/mfd/db8500-prcmu.c |  24 +++-----
 include/linux/mfd/core.h   |  29 ++++++++++
 3 files changed, 78 insertions(+), 113 deletions(-)

-- 
2.14.1
