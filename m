From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 17:28:41 +0100
Subject: [PATCH] ARM: dts: uniphier: fix a typo in comment block
In-Reply-To: <1450884220-8751-1-git-send-email-yamada.masahiro@socionext.com>
References: <1450884220-8751-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <2655737.rfUv6oI9D8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 December 2015 00:23:40 Masahiro Yamada wrote:
> 
> -/* UART3 unavilable: the pads are not wired to the package balls */
> +/* UART3 unavailable: the pads are not wired to the package balls */
>  &serial3 {
>         status = "disabled";
>  };
> 

Applied on next/dt, thanks!

	Arnd
