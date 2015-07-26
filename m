From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Jul 2015 21:40:18 +0200
Subject: [PATCH] ARM: nomadik: disable UART0 on Nomadik boards
In-Reply-To: <1437816123-7692-1-git-send-email-linus.walleij@linaro.org>
References: <1437816123-7692-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150726194018.GB494@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 11:22:03AM +0200, Linus Walleij wrote:
> The UART0 is not used on these boards, yet active and blocking
> other use. Fix this by disabling UART0 and setting port aliases
> to maintain port enumeration to userspace.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly to fixes if you're
> OK with it.

Applied, thanks!


-Olof
