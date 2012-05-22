From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 May 2012 10:06:45 +0300
Subject: [PATCH 1/4] ARM: OMAP3: There is no FS USB controller on omap3
In-Reply-To: <20120521190102.927.86158.stgit@muffinssi.local>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190102.927.86158.stgit@muffinssi.local>
Message-ID: <20120522070644.GA30559@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 12:01:02PM -0700, Tony Lindgren wrote:
> We should not select ARCH_OMAP_OTG as the hardware does not
> have the legacy FS (Full Speed) USB interface.
> 
> Cc: linux-usb at vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 4cf5142..0e4dd67 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -76,7 +76,6 @@ config SOC_OMAP3430
>  	bool "OMAP3430 support"
>  	depends on ARCH_OMAP3
>  	default y
> -	select ARCH_OMAP_OTG
>  
>  config SOC_TI81XX
>  	bool "TI81XX support"
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/bbf79609/attachment.sig>
