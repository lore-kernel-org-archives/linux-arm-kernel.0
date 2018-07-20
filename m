From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 09:12:07 +0200
Subject: [PATCH v3 01/33] mtd: rawnand: brcmnand: convert driver to
 nand_scan()
In-Reply-To: <20180720011719.7545fbb9@bbrezillon>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
 <20180719230026.8741-2-miquel.raynal@bootlin.com>
 <20180720011719.7545fbb9@bbrezillon>
Message-ID: <20180720091207.7828147d@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Fri, 20 Jul 2018
01:17:19 +0200:

> On Fri, 20 Jul 2018 00:59:54 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > +
> > +static struct nand_controller_ops brcmnand_controller_ops = {  
> 
> static const ...

Mmmh right, I'll constify every controller_ops definition.

> 
> The same comment applies to all patches of this series.
> 
> > +	.attach_chip = brcmnand_attach_chip,
> > +};  
> 


Miqu?l
