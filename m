From: npcomplete13@gmail.com (Vivek Unune)
Date: Thu, 27 Sep 2018 16:59:51 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Relicense BCM47094 file to the GPL
 2.0+ / MIT
In-Reply-To: <20180920112019.25622-1-zajec5@gmail.com>
References: <20180920112019.25622-1-zajec5@gmail.com>
Message-ID: <CAChtp753sZzQY8Jbsie2eW-j0cfM227AehcRf67puYAUCvELZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by Vivek Unune


On Thu, Sep 20, 2018 at 7:20 AM Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> This matches licensing used by other BCM5301X files and is preferred as:
> 1) GPL 2.0+ makes it clearly compatible with Linux kernel
> 2) MIT is also permissive but preferred over ISC
>
> This file has been developed by me & once modified by Vivek.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> Vivek: you have touched this file in the commit 37f6130ec39f ("ARM: dts:
> BCM5301X: Make USB 3.0 PHY use MDIO PHY driver").
>
> If you are OK with this relicensing, can you reply with
> Acked-by
> with your name, please?
> ---
>  arch/arm/boot/dts/bcm47094.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
> index f7c3e274b354..cdc5ff593adb 100644
> --- a/arch/arm/boot/dts/bcm47094.dtsi
> +++ b/arch/arm/boot/dts/bcm47094.dtsi
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  #include "bcm4708.dtsi"
> --
> 2.13.7
>
