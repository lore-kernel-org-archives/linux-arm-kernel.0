From: majun258@huawei.com (MaJun)
Date: Mon, 14 Mar 2016 14:45:05 +0800
Subject: [PATCH v2 0/2] Irq/Mbigen: fix the IO remap problem in mbigen driver.
Message-ID: <1457937907-14008-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch set is used to fix the problem of remap a set of registers
repeatedly.

Changes in v2:
--- Change the mbigen device node definition
--- Change the mbigen driver based on the new mbigen dts structure.

Ma Jun (2):
  Irq/mbigen:Change the mbigen node definition in dt binding file
  Irq/mbigen:Change the mbigen driver based on the new mbigen node definition

 .../interrupt-controller/hisilicon,mbigen-v2.txt   |   22 +++++++++++---
 drivers/irqchip/irq-mbigen.c                       |   30 ++++++++++++++------
 2 files changed, 38 insertions(+), 14 deletions(-)
