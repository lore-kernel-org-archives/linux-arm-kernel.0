From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 13:06:20 +0000
Subject: [PATCH 2/4] ARM: ks8695: use [readl|writel]_relaxed()
In-Reply-To: <1346264822-20347-1-git-send-email-linus.walleij@linaro.org>
References: <1346264822-20347-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201209031306.20812.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 August 2012, Linus Walleij wrote:
> I have no clue why __raw* macros are used here, but I strongly
> suspect there is no good reason at all for this, so removing
> another bad example.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Yes, looks good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
