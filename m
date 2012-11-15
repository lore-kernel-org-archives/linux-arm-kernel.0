From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 12:17:13 +0000
Subject: [PATCH] ARM: ux500: fix pin warning
In-Reply-To: <1352976439-24133-1-git-send-email-linus.walleij@stericsson.com>
References: <1352976439-24133-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201211151217.13486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Recent pin changes produce this warning:
> 
> arch/arm/mach-ux500/board-mop500-pins.c:73:22:
> error: 'out_hi_wkup_pdis' defined but not used
> [-Werror=unused-variable]
> 
> Fix this by deleting the offending definition.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on drivers branch, thanks!

	Arnd
