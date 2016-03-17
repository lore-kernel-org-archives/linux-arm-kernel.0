From: majun258@huawei.com (MaJun)
Date: Thu, 17 Mar 2016 16:33:59 +0800
Subject: [PATCH v3 0/2] irqchip/mbigen: fix the IO remap problem in mbigen
 driver.
Message-ID: <1458203641-17172-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch set is used to fix the problem of remap a set of registers
repeatedly in current mbigen driver.

Changes in v3:
--- Change the log to make more detail description about
	the IO remap problem.

Changes in v2:
--- Change the mbigen device node definition as Mark suggested.
--- Change the mbigen driver based on the new mbigen dts structure.

Ma Jun (2):
  irqchip/mbigen:Change the mbigen node definition in dt binding file
  irqchip/mbigen:Change the mbigen driver based on the new mbigen node definition

 .../interrupt-controller/hisilicon,mbigen-v2.txt   |   22 +++++++++++---
 drivers/irqchip/irq-mbigen.c                       |   30 ++++++++++++++------
 2 files changed, 38 insertions(+), 14 deletions(-)
