From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Nov 2011 13:48:52 +0800
Subject: [PATCH 1/2] ARM: mxs/tx28: add __initconst for fec pdata
In-Reply-To: <1321027746-5906-1-git-send-email-b29396@freescale.com>
References: <1321027746-5906-1-git-send-email-b29396@freescale.com>
Message-ID: <20111122054851.GF16417@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 12:09:05AM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---

Applied, thanks.

Regards,
Shawn

>  arch/arm/mach-mxs/module-tx28.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
> index 0fcff47..9a7b08b 100644
> --- a/arch/arm/mach-mxs/module-tx28.c
> +++ b/arch/arm/mach-mxs/module-tx28.c
> @@ -66,11 +66,11 @@ static const iomux_cfg_t tx28_fec1_pads[] __initconst = {
>  	MX28_PAD_ENET0_CRS__ENET1_RX_EN,
>  };
>  
> -static struct fec_platform_data tx28_fec0_data = {
> +static const struct fec_platform_data tx28_fec0_data __initconst = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
>  };
>  
> -static struct fec_platform_data tx28_fec1_data = {
> +static const struct fec_platform_data tx28_fec1_data __initconst = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
>  };
>  
> -- 
> 1.7.0.4
> 
