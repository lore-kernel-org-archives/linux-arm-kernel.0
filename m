From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 18 Sep 2014 21:43:45 +0800
Subject: [PATCH V2 1/2] ARM: imx: replace cpu type check with ddr type
 check
In-Reply-To: <1410923506-21439-1-git-send-email-b20788@freescale.com>
References: <1410923506-21439-1-git-send-email-b20788@freescale.com>
Message-ID: <20140918134344.GJ4796@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 11:11:45AM +0800, Anson Huang wrote:
> diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> index 17a41ca..caea07b 100644
> --- a/arch/arm/mach-imx/mxc.h
> +++ b/arch/arm/mach-imx/mxc.h
> @@ -55,6 +55,8 @@
>  #define IMX_CHIP_REVISION_3_3		0x33
>  #define IMX_CHIP_REVISION_UNKNOWN	0xff
>  
> +#define DDR_TYPE_LPDDR2		1

We should give it a name-space.  I renamed it to IMX_DDR_TYPE_LPDDR2
and applied both patches.

Shawn
