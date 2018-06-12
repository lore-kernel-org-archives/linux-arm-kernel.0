From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2018 15:32:42 -0300
Subject: [PATCH] arm64: dts: freescale: Update to use SPDX identifiers
In-Reply-To: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
References: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Li,

On Tue, Jun 12, 2018 at 3:28 PM, Li Yang <leoyang.li@nxp.com> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> index 7286b1e..f90c040 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -1,45 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Here you use GPL-2.0+

>  /*
>   * Device Tree file for Freescale LS1012A Freedom Board.
>   *
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPLv2 or the X11 license, at your option. Note that this dual

,but the original text says  GPL-2.0, not  GPL-2.0+, so there is a mismatch.
