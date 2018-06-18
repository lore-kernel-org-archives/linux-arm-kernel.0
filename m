From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 18 Jun 2018 16:00:23 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180618103908.17a04679@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180618103908.17a04679@bbrezillon>
Message-ID: <20180618160023.3380fade@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, 18 Jun 2018 10:39:08 +0200, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> On Thu, 29 Mar 2018 15:10:54 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> > On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> > flash accesses have a tendency to cause display disturbances. Add a
> > module param to disable DMA from the NAND controller, since that fixes
> > the display problem for me.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>  
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Miquel, can you queue this one to nand/next.

Yes of course.

I'll just change the subject to "mtd: rawnand: atmel:".

Thanks,
Miqu?l
