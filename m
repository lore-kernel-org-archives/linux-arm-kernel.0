From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 13:35:48 +0200
Subject: [PATCH] ARM: dts: berlin: fix typo in chosen property
In-Reply-To: <1444734729-4818-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1444734729-4818-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20151013113547.GA20884@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 13, 2015 at 01:12:09PM +0200, Michael Opdenacker wrote:
> This fixes a trivial typo in the name of the "chosen" device tree property
> for the Marvell BG2-Q DMP board.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

> ---
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index 4a749e5b3b44..caeeb345c335 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -48,7 +48,7 @@
>  		reg = <0x00000000 0x80000000>;
>  	};
>  
> -	choosen {
> +	chosen {
>  		bootargs = "console=ttyS0,115200 earlyprintk";
>  	};
>  
> -- 
> 2.1.4
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
