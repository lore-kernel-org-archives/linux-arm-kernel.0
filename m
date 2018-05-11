From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 May 2018 16:08:05 +0800
Subject: [PATCH] ARM: dts: imx: Switch to SPDX identifier
In-Reply-To: <1525717420-9360-1-git-send-email-festevam@gmail.com>
References: <1525717420-9360-1-git-send-email-festevam@gmail.com>
Message-ID: <20180511080804.GC26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 03:23:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx1.dtsi    | 13 +++---------
>  arch/arm/boot/dts/imx23.dtsi   | 13 +++---------
>  arch/arm/boot/dts/imx25.dtsi   | 13 +++---------
>  arch/arm/boot/dts/imx27.dtsi   | 13 +++---------
>  arch/arm/boot/dts/imx28.dtsi   | 13 +++---------
>  arch/arm/boot/dts/imx31.dtsi   | 13 +++---------
>  arch/arm/boot/dts/imx35.dtsi   | 14 +++++--------
>  arch/arm/boot/dts/imx51.dtsi   | 15 ++++----------
>  arch/arm/boot/dts/imx6dl.dtsi  | 12 +++--------
>  arch/arm/boot/dts/imx6q.dtsi   | 12 +++--------
>  arch/arm/boot/dts/imx6qdl.dtsi | 15 ++++----------
>  arch/arm/boot/dts/imx6qp.dtsi  | 44 +++-------------------------------------
>  arch/arm/boot/dts/imx6sl.dtsi  | 11 +++-------
>  arch/arm/boot/dts/imx6sx.dtsi  | 10 +++------
>  arch/arm/boot/dts/imx6ul.dtsi  | 10 +++------
>  arch/arm/boot/dts/imx7d.dtsi   | 46 ++++--------------------------------------
>  arch/arm/boot/dts/imx7s.dtsi   | 46 ++++--------------------------------------
>  17 files changed, 57 insertions(+), 256 deletions(-)

<snip>

> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 6c28b9c..08ea75ae 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -1,13 +1,6 @@
> -/*
> - * Copyright 2012 Sascha Hauer, Pengutronix
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
> +//Copyright 2012 Sascha Hauer, Pengutronix

A space is missing right after //.

Fixed it up and applied the patch.

Shawn
