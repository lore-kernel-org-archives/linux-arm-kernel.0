From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Nov 2015 12:19:11 +0100
Subject: [PATCH v2 08/10] ARM: dts: imx: Update vendor info for GE
 Bx50v3 boards
In-Reply-To: <1446747224-32514-9-git-send-email-akshay.bhat@timesys.com>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
 <1446747224-32514-9-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1447154351.3142.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 05.11.2015, 13:13 -0500 schrieb Akshay Bhat:
> Update vendor and copyright info for GE Bx50v3 boards
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

This one and the following patches should be folded into the patches
introducing the files being patched here. They fix the original patches
and it makes no sense to merge patches with slightly wrong DTs, just to
immediately following up with patches to fix things.

Regards,
Lucas

> ---
>  arch/arm/boot/dts/imx6q-b450v3.dts | 4 ++--
>  arch/arm/boot/dts/imx6q-b650v3.dts | 4 ++--
>  arch/arm/boot/dts/imx6q-b850v3.dts | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
> index d63d9e1..efe9c1e 100644
> --- a/arch/arm/boot/dts/imx6q-b450v3.dts
> +++ b/arch/arm/boot/dts/imx6q-b450v3.dts
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright 2015 Timesys Corporation.
> - * Copyright 2015 GE Healthcare.
> + * Copyright 2015 General Electric Company
>   *
>   * The code contained herein is licensed under the GNU General Public
>   * License. You may obtain a copy of the GNU General Public License
> @@ -16,7 +16,7 @@
>  
>  / {
>  	model = "Advantech MX6Q B450V3 QSeven Board";
> -	compatible = "adv,imx6q-b450v3", "adv,imx6q-ba16", "fsl,imx6q";
> +	compatible = "ge,imx6q-b450v3", "adv,imx6q-ba16", "fsl,imx6q";
>  
>  	chosen {
>  		stdout-path = &uart3;
> diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
> index 29cbdb0..d40efa9 100644
> --- a/arch/arm/boot/dts/imx6q-b650v3.dts
> +++ b/arch/arm/boot/dts/imx6q-b650v3.dts
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright 2015 Timesys Corporation.
> - * Copyright 2015 GE Healthcare.
> + * Copyright 2015 General Electric Company
>   *
>   * The code contained herein is licensed under the GNU General Public
>   * License. You may obtain a copy of the GNU General Public License
> @@ -16,7 +16,7 @@
>  
>  / {
>  	model = "Advantech MX6Q B650V3 QSeven Board";
> -	compatible = "adv,imx6q-b650v3", "adv,imx6q-ba16", "fsl,imx6q";
> +	compatible = "ge,imx6q-b650v3", "adv,imx6q-ba16", "fsl,imx6q";
>  
>  	chosen {
>  		stdout-path = &uart3;
> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
> index be6c0da..a77f392 100644
> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright 2015 Timesys Corporation.
> - * Copyright 2015 GE Healthcare.
> + * Copyright 2015 General Electric Company
>   *
>   * The code contained herein is licensed under the GNU General Public
>   * License. You may obtain a copy of the GNU General Public License
> @@ -16,7 +16,7 @@
>  
>  / {
>  	model = "Advantech MX6Q B850V3 QSeven Board";
> -	compatible = "adv,imx6q-b850v3", "adv,imx6q-ba16", "fsl,imx6q";
> +	compatible = "ge,imx6q-b850v3", "adv,imx6q-ba16", "fsl,imx6q";
>  
>  	chosen {
>  		stdout-path = &uart3;

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
