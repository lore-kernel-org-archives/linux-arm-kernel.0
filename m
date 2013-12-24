From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 24 Dec 2013 20:00:43 +0400
Subject: [PATCH 15/21] ARM: shmobile: Remove Koelsch reference DTS
In-Reply-To: <82f7c2065a363cd3c0c84d3c9b59ee47897c5ebb.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
 <82f7c2065a363cd3c0c84d3c9b59ee47897c5ebb.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <52B9AFAB.8040704@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-12-2013 18:19, Simon Horman wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Now that the DTS file r8a7790-koelsch.dts can be used with
> board-koelsch.c and board-koelsch-reference.c, proceed with removing
> r8a7790-koelsch-reference.dts.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/Makefile | 1 -
>   1 file changed, 1 deletion(-)

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 909d910..5839077 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -225,7 +225,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
>   	r8a7779-marzen.dtb \
>   	r8a7779-marzen-reference.dtb \
>   	r8a7791-koelsch.dtb \
> -	r8a7791-koelsch-reference.dtb \
>   	r8a7790-lager.dtb \
>   	r8a7790-lager-reference.dtb \

    Hm, the previous commit removed that file itself but forgot to remove it 
from the Makefile.

>   	sh73a0-kzm9g.dtb \

    I suspect this patch should have removed the *.dts fiel itself but failed 
to do so...

WBR, Sergei
