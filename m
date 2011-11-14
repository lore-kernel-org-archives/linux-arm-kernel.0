From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 14 Nov 2011 06:28:37 +0100
Subject: [PATCH 1/2] ARM: mxs/tx28: add __initconst for fec pdata
In-Reply-To: <1321027746-5906-1-git-send-email-b29396@freescale.com>
References: <1321027746-5906-1-git-send-email-b29396@freescale.com>
Message-ID: <20160.42757.797468.259912@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng writes:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
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
Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
