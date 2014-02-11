From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Feb 2014 22:22:16 +0100
Subject: [PATCH 4/9] ARM: Select V6K instead of V6 by default for
 multi-platform
In-Reply-To: <1392153119-23248-5-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-5-git-send-email-robherring2@gmail.com>
Message-ID: <1492617.b9HLFpaExO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 February 2014 15:11:54 Rob Herring wrote:
> @@ -1,9 +1,9 @@
>  config ARCH_CNS3XXX
>         bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
>         select ARM_GIC
> -       select CPU_V6K
>         select MIGHT_HAVE_PCI
>         select PCI_DOMAINS if PCI
> +       select CPU_V6
>         help
>           Support for Cavium Networks CNS3XXX platform.

I thought we had concluded that CNS3xxx is V6K as well. Do you
have newer information? Maybe Anton remembers.

	Arnd
