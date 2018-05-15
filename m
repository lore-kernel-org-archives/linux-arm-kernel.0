From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 May 2018 15:55:33 +0800
Subject: [PATCH] ARM: dts: imx: Switch NXP boards to SPDX identifier
In-Reply-To: <1526320727-29157-1-git-send-email-festevam@gmail.com>
References: <1526320727-29157-1-git-send-email-festevam@gmail.com>
Message-ID: <20180515075532.GQ26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 02:58:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx23-evk.dts          | 13 +++-------
>  arch/arm/boot/dts/imx25-pdk.dts          | 13 +++-------
>  arch/arm/boot/dts/imx27-pdk.dts          | 13 +++-------
>  arch/arm/boot/dts/imx28-evk.dts          | 13 +++-------
>  arch/arm/boot/dts/imx35-pdk.dts          | 15 +++--------
>  arch/arm/boot/dts/imx50-evk.dts          | 17 ++++--------
>  arch/arm/boot/dts/imx51-babbage.dts      | 15 +++--------
>  arch/arm/boot/dts/imx53-qsb-common.dtsi  | 15 +++--------
>  arch/arm/boot/dts/imx53-qsb.dts          | 15 +++--------
>  arch/arm/boot/dts/imx53-qsrb.dts         | 15 +++--------
>  arch/arm/boot/dts/imx53-smd.dts          | 17 ++++--------
>  arch/arm/boot/dts/imx6dl-sabreauto.dts   | 10 +++-----
>  arch/arm/boot/dts/imx6dl-sabresd.dts     | 10 +++-----
>  arch/arm/boot/dts/imx6q-sabreauto.dts    | 16 ++++--------
>  arch/arm/boot/dts/imx6q-sabresd.dts      | 15 +++--------
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 15 +++--------
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 15 +++--------
>  arch/arm/boot/dts/imx6qp-sabreauto.dts   | 44 +++-----------------------------
>  arch/arm/boot/dts/imx6qp-sabresd.dts     | 44 +++-----------------------------
>  arch/arm/boot/dts/imx6sl-evk.dts         | 10 +++-----
>  arch/arm/boot/dts/imx6sx-sabreauto.dts   | 10 +++-----
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts   | 10 +++-----
>  arch/arm/boot/dts/imx7d-sdb-sht11.dts    | 44 +++-----------------------------
>  arch/arm/boot/dts/imx7d-sdb.dts          | 44 +++-----------------------------
>  24 files changed, 86 insertions(+), 362 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
> index 9d92ece82..d3cdd3b 100644
> --- a/arch/arm/boot/dts/imx23-evk.dts
> +++ b/arch/arm/boot/dts/imx23-evk.dts
> @@ -1,13 +1,6 @@
> -/*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2012 Freescale Semiconductor, I/*

I/*?  Should be Inc.

<snip>

> diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
> index 334b924..66f2728 100644
> --- a/arch/arm/boot/dts/imx6q-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
> @@ -1,14 +1,8 @@
> -/*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> - * Copyright 2011 Linaro Ltd.
> - *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> - *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2012 Freescale Semiconductor, Inc.
> +// Copyright 2011 Linaro Ltd.
> +

Unnecessary newline.

>  
>  /dts-v1/;
>  

I fixed them up and applied the patch.

Shawn
