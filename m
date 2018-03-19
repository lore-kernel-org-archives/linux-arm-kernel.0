From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 19 Mar 2018 23:47:29 +0100
Subject: [PATCH v2 2/2] mtd: nand: Remove print after allocation failure
In-Reply-To: <1521390796-13715-2-git-send-email-arushisinghal19971997@gmail.com>
References: <1521390796-13715-1-git-send-email-arushisinghal19971997@gmail.com>
 <1521390796-13715-2-git-send-email-arushisinghal19971997@gmail.com>
Message-ID: <20180319234729.73fb800d@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arushi,

On Sun, 18 Mar 2018 22:03:16 +0530, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() etc. functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *done the similar changes in other files.
> 
>  drivers/mtd/nand/ams-delta.c             |  1 -
>  drivers/mtd/nand/atmel/nand-controller.c | 13 +++---------
>  drivers/mtd/nand/marvell_nand.c          |  8 ++------
>  drivers/mtd/nand/nandsim.c               | 35 ++++++++------------------------
>  drivers/mtd/nand/ndfc.c                  |  4 +---
>  drivers/mtd/nand/sunxi_nand.c            |  4 +---
>  6 files changed, 15 insertions(+), 50 deletions(-)
> 


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
