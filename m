From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 May 2015 22:56:50 +0100
Subject: [PATCH] ARM: dts: cubox-i/hummingboard: Fix the license text
In-Reply-To: <1432148222-12603-1-git-send-email-festevam@gmail.com>
References: <1432148222-12603-1-git-send-email-festevam@gmail.com>
Message-ID: <20150520215650.GA2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 03:57:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Arrange the license text a bit to make it clear.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks for fixing this Fabio.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/boot/dts/imx6dl-cubox-i.dts           | 5 ++---
>  arch/arm/boot/dts/imx6dl-hummingboard.dts      | 5 ++---
>  arch/arm/boot/dts/imx6q-cubox-i.dts            | 5 ++---
>  arch/arm/boot/dts/imx6q-hummingboard.dts       | 5 ++---
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi         | 5 ++---
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi    | 5 ++---
>  arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 5 ++---
>  arch/arm/boot/dts/imx6qdl-microsom.dtsi        | 5 ++---
>  8 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> index e0b7fe8..2a43917 100644
> --- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> @@ -7,9 +7,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
> index 7369d2d..d5c9660 100644
> --- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
> +++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
> @@ -8,9 +8,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
> index 670bd8c..353425e 100644
> --- a/arch/arm/boot/dts/imx6q-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
> @@ -7,9 +7,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/imx6q-hummingboard.dts
> index 0f60445..1884c16 100644
> --- a/arch/arm/boot/dts/imx6q-hummingboard.dts
> +++ b/arch/arm/boot/dts/imx6q-hummingboard.dts
> @@ -8,9 +8,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> index d033bb1..59e5d15 100644
> --- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> @@ -7,9 +7,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index e56b44c..62a82f3 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -7,9 +7,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> index 4a18203..469ef58 100644
> --- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> @@ -10,9 +10,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
> index ec6c7c7..6d4069c 100644
> --- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
> @@ -7,9 +7,8 @@
>   * whole.
>   *
>   *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License.
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
>   *
>   *     This file is distributed in the hope that it will be useful
>   *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> -- 
> 1.9.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
