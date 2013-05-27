From: philippe.begnic.st@gmail.com (Philippe Begnic)
Date: Mon, 27 May 2013 14:41:28 +0200
Subject: [PATCH 0/4] clk, mfd: u8540 clock tree definition
Message-ID: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Begnic <philippe.begnic@st.com>

Create U8540 clock tree definitions for common clock framework

Philippe Begnic (4):
  clk: ux500: Pass clock base adresses in initcall for u8540 and u9540
  mfd: db8500: Update register definition for u8540 clock
  mfd: db8500: Update BML clock register for db8580
  clk: ux500: Clocks definition for u8540

 arch/arm/mach-ux500/cpu.c                 |    6 +-
 drivers/clk/ux500/u8540_clk.c             |  564 ++++++++++++++++++++++++++++-
 drivers/clk/ux500/u9540_clk.c             |    4 +-
 drivers/mfd/db8500-prcmu.c                |    1 +
 drivers/mfd/dbx500-prcmu-regs.h           |    1 +
 include/linux/mfd/abx500/ab8500-sysctrl.h |    4 +-
 include/linux/mfd/dbx500-prcmu.h          |   12 +
 include/linux/platform_data/clk-ux500.h   |    6 +-
 8 files changed, 587 insertions(+), 11 deletions(-)

-- 
1.7.9.5
