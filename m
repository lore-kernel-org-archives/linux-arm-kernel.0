From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 6 Jun 2016 22:03:07 +0300
Subject: [PATCH v2 10/11] ARM: dts: blanche: initial device tree
In-Reply-To: <13571934.l66Gg7Cpm9@wasted.cogentembedded.com>
References: <3446154.oZ24315zaL@wasted.cogentembedded.com>
 <13571934.l66Gg7Cpm9@wasted.cogentembedded.com>
Message-ID: <4fe5c4ec-11a0-7e8a-cad1-91c0c30702df@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2016 12:35 AM, Sergei Shtylyov wrote:

> Add the initial device  tree for the R8A7792 SoC based Blanche board.
> The board has 2 debug serial ports: SCIF0 and SCIF3; include support for
> them,  so that  the serial console  can  work.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

[...]
> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Device Tree Source for the Blanche board
> + *
> + * Copyright (C) 2016 Cogent Embedded, Inc.

    Looks like I need to add the Renesas Electronics copyright here. Pleae 
hold one merging this patch as well.

MBR, Sergei
