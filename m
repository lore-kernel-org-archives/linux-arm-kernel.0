From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 20 Jul 2018 01:17:19 +0200
Subject: [PATCH v3 01/33] mtd: rawnand: brcmnand: convert driver to
 nand_scan()
In-Reply-To: <20180719230026.8741-2-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
 <20180719230026.8741-2-miquel.raynal@bootlin.com>
Message-ID: <20180720011719.7545fbb9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 00:59:54 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> +
> +static struct nand_controller_ops brcmnand_controller_ops = {

static const ...

The same comment applies to all patches of this series.

> +	.attach_chip = brcmnand_attach_chip,
> +};
