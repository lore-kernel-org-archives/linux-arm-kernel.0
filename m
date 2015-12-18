From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 14:28:06 +0100
Subject: [PATCH] ARM: realview: select apropriate targets in defconfig
In-Reply-To: <1450444794-18478-1-git-send-email-linus.walleij@linaro.org>
References: <1450444794-18478-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3702930.VaLXyyDAE1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 14:19:54 Linus Walleij wrote:
> After adding multiplatform support for the RealView, we need
> to add the apropriate targets to the defconfig so we get the
> full range of supported devices. This amends both the defconfig
> files for this.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Looks good to me. Should we also add PBX to multi_v7_defconfig?

	Arnd
