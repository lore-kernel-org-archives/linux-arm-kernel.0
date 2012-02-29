From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 29 Feb 2012 14:40:42 -0600
Subject: [PATCH v2 16/28] ARM: remove bunch of now unused mach/io.h files
In-Reply-To: <1330547147-22867-17-git-send-email-robherring2@gmail.com>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <1330547147-22867-17-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FE96B60@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 29, 2012 1:26 PM, Rob Herring wrote:
>
> Now that many platforms don't need mach/io.h, remove the usused ones.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---

<...>

arch/arm/mach-ep93xx/include/mach/io.h    |   13 --------

<...>

 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h

<...>

> diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
> deleted file mode 100644
> index 17e76ef..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/io.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/io.h
> - */
> -
> -#ifndef __ASM_MACH_IO_H
> -#define __ASM_MACH_IO_H
> -
> -#define IO_SPACE_LIMIT		0xffffffff
> -
> -#define __io(p)			__typesafe_io(p)
> -#define __mem_pci(p)		(p)
> -
> -#endif /* __ASM_MACH_IO_H */

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
