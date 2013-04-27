From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:08:02 -0700
Subject: [PATCH] ARM: u300: fix ages old copy/paste bug
In-Reply-To: <1366982995-10870-1-git-send-email-linus.walleij@stericsson.com>
References: <1366982995-10870-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130427000802.GA1285@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 03:29:55PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The UART1 is on the fast AHB bridge, not on the slow bus.
> 
> Cc: stable at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks, as discussed with Arnd, please apply
> this patch directly for fixes.

Thanks, applied to next/fixes-non-critical.


-Olof
