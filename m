From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 14 Sep 2016 21:49:52 +0800
Subject: [PATCH 0/2] minor cleanups for IORT patch set
Message-ID: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Minor cleanup for IORT patches and no functional change,
based on Marc's irq/irqchip-4.9 branch

Hanjun Guo (2):
  ACPI: IORT: minor cleanup for iort_match_node_callback()
  irqchip: gic-v3-its: keep the head file include in alphabetic order

 drivers/acpi/arm64/iort.c        | 10 +++-------
 drivers/irqchip/irq-gic-v3-its.c |  3 +--
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
1.7.12.4
