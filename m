From: ralf@linux-mips.org (Ralf Baechle)
Date: Fri, 5 Jun 2015 10:48:03 +0200
Subject: [Patch v3 35/36] genirq: Pass irq_data to helper function
 __irq_set_chip_handler_name_locked()
In-Reply-To: <1433145945-789-36-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
 <1433145945-789-36-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150605084803.GY26432@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 04:05:44PM +0800, Jiang Liu wrote:

For arch/mips/alchemy/common/irq.c:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
