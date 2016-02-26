From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 17:44:15 +0100
Subject: [PATCH] ARM: ux500: fix ureachable iounmap()
In-Reply-To: <1456129862-3918-1-git-send-email-linus.walleij@linaro.org>
References: <1456129862-3918-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2990822.bsnxXF07U9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 February 2016 09:31:02 Linus Walleij wrote:
> The code was executing a return with a pointer before reaching
> iounmap().
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I have no other Ux500 patches queued, so can
> you please apply this patch directly for-next somewhere,
> thanks.
> 

Applied to next/fixes-non-critical, thanks!

	Arnd
