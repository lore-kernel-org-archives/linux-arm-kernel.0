From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 3 Sep 2012 10:10:08 +0000
Subject: [PATCH 4/9] ARM: OMAP2+: Remove unused nand_irq for GPMC
In-Reply-To: <20120831005228.28732.90454.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005228.28732.90454.stgit@muffinssi.local>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DC383@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Aug 31, 2012 at 06:22:28, Tony Lindgren wrote:
> This is no longer needed and assumes a fixed IRQ number
> that won't work with SPARSE_IRQ.

This cleanup was overlooked in mtd gpmc driver
preparation series

Acked-by: Afzal Mohammed <afzal@ti.com>

Regards
Afzal
