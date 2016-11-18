From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 14:02:48 +0100
Subject: [PATCH] kirkwood: fix spelling mistake
In-Reply-To: <trinity-6911950b-e19a-4b44-aeed-adaccbc33164-1479414587776@3capp-gmx-bs50>
 (p. wassi's message of "Thu, 17 Nov 2016 21:29:47 +0100")
References: <trinity-6911950b-e19a-4b44-aeed-adaccbc33164-1479414587776@3capp-gmx-bs50>
Message-ID: <87polt9c07.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
 
 On jeu., nov. 17 2016, p.wassi at gmx.at wrote:

> From: Paul Wassi <p.wassi@gmx.at>
>
> Fix a spelling mistake in arch/arm/boot/dts/kirkwood-topkick.dts
>
> Signed-off-by: Paul Wassi <p.wassi@gmx.at>

Applied on mvebu/dt.

I fix the title, as for patcj modifying the dts, the title should start
by "ARM: dts: ". I also added the comment from the email which add more
inforamtion that the original commit log.

Thanks,

Gregory

> ---
> The manufacturer's name is Univer*s*al Scientific Industrial...
> Compare with footer of page here:
> http://www.usish.com/english/products_topkick1281p2.php
>
>  arch/arm/boot/dts/kirkwood-topkick.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -rupN a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
> --- a/arch/arm/boot/dts/kirkwood-topkick.dts
> +++ b/arch/arm/boot/dts/kirkwood-topkick.dts
> @@ -4,7 +4,7 @@
>  #include "kirkwood-6282.dtsi"
>  
>  / {
> -	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
> +	model = "Universal Scientific Industrial Co. Topkick-1281P2";
>  	compatible = "usi,topkick-1281P2", "usi,topkick", "marvell,kirkwood-88f6282", "marvell,kirkwood";
>  
>  	memory {
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
