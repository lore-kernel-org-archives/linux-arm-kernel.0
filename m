From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:53 +0200
Subject: [PATCH 0/8] Zynq GPIO driver changes
Message-ID: <cover.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the patchset contains several patches which adding new functionality to
the driver (irq wakeup, suspend/resume) and fixing issue with DATA_RO
reg. The rest of changes are fixing kernel-doc and checkpatch warnings.

Thanks,
Michal


Borsodi Petr (1):
  gpio: zynq: Wakeup gpio controller when it is used as IRQ controller

Michal Simek (2):
  gpio: zynq: Fix empty lines in driver
  gpio: zynq: Fix driver function parameters alignment

Nava kishore Manne (3):
  gpio: zynq: Shift zynq_gpio_init() to subsys_initcall level
  gpio: zynq: Fix kernel doc warnings
  gpio: zynq: Fix warnings in the driver

Shubhrajyoti Datta (1):
  gpio: zynq: Add support for suspend resume

Swapna Manupati (1):
  gpio: zynq: Provided workaround for GPIO

 drivers/gpio/gpio-zynq.c | 201 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 176 insertions(+), 25 deletions(-)

-- 
1.9.1
