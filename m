From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 May 2013 23:50:03 -0700
Subject: [PATCH] ARM: nomadik: fix IRQ assignment for SMC ethernet
In-Reply-To: <1368917259-7883-1-git-send-email-linus.walleij@linaro.org>
References: <1368917259-7883-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130521065003.GI20453@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 12:47:39AM +0200, Linus Walleij wrote:
> The assignment of IRQ for the SMC91x ethernet adapter had two
> problems making it non-working:
> 
> - It was not put into the ethernet device node. Let's do this
>   by using the board-specific overlay, so we can make other
>   overlays on other Nomadik boards.
> 
> - The IRQ number was actually completely wrong, this was the
>   number for NHK8815, not S8815.
> 
> After this ethernet starts working on the USB S8815.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I would appreciate if you apply this patch
> directly for v3.10 fixes.

Done.

-Olof
