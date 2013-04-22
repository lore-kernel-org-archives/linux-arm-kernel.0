From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 13:34:03 +0200
Subject: [PATCH 01/23] ARM: u300: fix ages old copy/paste bug
In-Reply-To: <1366624283-6122-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624283-6122-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201304221334.04160.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The UART1 is on the fast AHB bridge, not on the slow bus.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Do you want to mark this for stable?

While there are not a lot of people that would need the fix, I think 
we should do it by habit in cases that fit the stable rules.

Acked-by: Arnd Bergmann <arnd@arndb.de>
