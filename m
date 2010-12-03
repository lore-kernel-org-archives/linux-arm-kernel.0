From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 20:54:56 +0000
Subject: [PATCH] ARM: GIC irq desciptor bug fix
In-Reply-To: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
References: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
Message-ID: <20101203205456.GD10245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 02:17:39PM +0800, Chao at marvell.com wrote:
> From: cxie4 <cxie4@marvell.com>
> 
> gic_set_cpu will directly use irq_desc[]. If CONFIG_SPARSE_IRQ is enabled, there is no

"SPARSE_IRQ" will do.  Please also wrap commit comments so they fit
within 72 columns.

> irq_desc[]. So we need use irq_to_desc(irq) to get the descriptor for irq.

Patch looks fine, please send (with Kyungmin's ack) to my patch system,
thanks.
