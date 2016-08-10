From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 14:45:53 +0200
Subject: [PATCH 5/5] ARM: realview: imply device tree boot
In-Reply-To: <1470832830-10274-6-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
 <1470832830-10274-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <46161768.rdKeJ7WGu8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 2:40:30 PM CEST Linus Walleij wrote:
> +         This enables support for ARM Ltd RealView boards.
> +
> +if ARCH_REALVIEW
>  
>  config REALVIEW_HIGH_PHYS_OFFSET
>         bool "High physical base address for the RealView platform"
> 

REALVIEW_HIGH_PHYS_OFFSET can be removed as well now, I think it
is completely unused after your patches.

	Arnd
