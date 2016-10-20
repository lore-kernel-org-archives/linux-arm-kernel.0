From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 20 Oct 2016 08:32:34 +0200
Subject: [PATCH] ARM: dts: berlin2q-marvell-dmp: fix typo in chosen node
In-Reply-To: <1476924731-14975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476924731-14975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161020063234.a4q7qquftwn5kvup@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 20, 2016 at 09:52:11AM +0900, Masahiro Yamada wrote:
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

> ---
> 
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index f485308..d57d675 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -48,7 +48,7 @@
>  		reg = <0x00000000 0x80000000>;
>  	};
>  
> -	choosen {
> +	chosen {
>  		bootargs = "earlyprintk";
>  		stdout-path = "serial0:115200n8";
>  	};
> -- 
> 1.9.1
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/8d11fa4f/attachment.sig>
