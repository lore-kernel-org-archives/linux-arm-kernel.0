From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 Apr 2014 09:15:58 +0900
Subject: [PATCH] ARM: shmobile: henninger: enable SATA0
In-Reply-To: <201404260251.28274.sergei.shtylyov@cogentembedded.com>
References: <201404260251.28274.sergei.shtylyov@cogentembedded.com>
Message-ID: <20140428001558.GN32087@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 02:51:27AM +0400, Sergei Shtylyov wrote:
> Enable SATA0 device for the Henninger board. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up.

> 
> ---
> This patch is against 'renesas-devel-v3.15-rc2-20140425v2' tag of Simon Horman's
> 'renesas.git' repo.
> 
>  arch/arm/boot/dts/r8a7791-henninger.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
> +++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> @@ -74,3 +74,7 @@
>  		micrel,led-mode = <1>;
>  	};
>  };
> +
> +&sata0 {
> +       status = "okay";
> +};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
