From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Fri, 21 Jan 2011 13:41:53 +0530
Subject: [PATCH] omap3: nand: bch ecc support added
In-Reply-To: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
Message-ID: <AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ghorai,

<snip>

> ?#ifdef CONFIG_MTD_PARTITIONS
> diff --git a/drivers/mtd/nand/omap_bch_decoder.c b/drivers/mtd/nand/omap_bch_decoder.c
> new file mode 100644
> index 0000000..da42bda
> --- /dev/null
> +++ b/drivers/mtd/nand/omap_bch_decoder.c
> @@ -0,0 +1,393 @@
> +/*
> + * drivers/mtd/nand/omap_omap_bch_decoder.c
> + *
> + * Whole BCH ECC Decoder (Post hardware generated syndrome decoding)
> + *
> + * Copyright (c) 2007 Texas Instruments
> + *
> + * Author: Sukumar Ghorai <s-ghorai@ti.com
> + * ? ? ? ? ? ? ? ?Michael Fillinger <m-fillinger@ti.com>

Vimal was the original author who has created this file
[No change in file name/directory hierarchy].
It's not fair to remove Vimal's author and add your's.

Instead you should have kept his name and added your's.

<snip>

Regards,
Kishore
