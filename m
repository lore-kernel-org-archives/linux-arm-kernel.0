From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 17:00:04 +0200
Subject: [PATCH v7 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
In-Reply-To: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <2101307.fSn8Z2ZyBq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 13:07:10 Masahiro Yamada wrote:
> This is an initial series for supporting Socionext UniPhier SoCs,
> based on ARM Cortex-A9, mainly used for digital TVs, video recorders, etc.
> 
> 
> Masahiro Yamada (4):
>   ARM: UniPhier: add basic support for UniPhier architecture
>   ARM: multi_v7_defconfig: enable UniPhier SoC family
>   ARM: dts: UniPhier: add support for UniPhier SoCs and boards
>   MAINTAINERS: add myself as ARM/UniPhier maintainer

Applied all four patches, to the next/soc, next/defconfig, next/dt and
next/soc branches respectively.

Welcome as our latest new maintainer. In the future, please send
any follow-up patches for the architecture specific code to
arm at kernel.org in addition to the normal recipients, once you
consider them ready to be applied.

	Arnd
