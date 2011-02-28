From: leiwen@marvell.com (Lei Wen)
Date: Mon, 28 Feb 2011 10:32:09 +0800
Subject: [PATCH 0/6] pxa3xx_nand update series set version 5
In-Reply-To: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
References: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
Message-ID: <1298860335-18638-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V4:
rework the patch set accroding to Eric's suggestion.
Move the recode judgement to the after command execution.

V5:
clean code style issue.

Lei Wen (6):
  pxa3xx_nand: make scan procedure more clear
  pxa3xx_nand: rework irq logic
  pxa3xx_nand: discard wait_for_event,write_cmd,__readid function
  pxa3xx_nand: unify prepare command
  pxa3xx_nand: mtd scan id process could be defined by driver itself
  pxa3xx_nand: clean the keep configure code

 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  977 ++++++++++++--------------
 2 files changed, 458 insertions(+), 521 deletions(-)
