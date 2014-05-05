From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 May 2014 20:56:09 -0700
Subject: [PATCH] ARM: at91: localize GPIO header
In-Reply-To: <1395924553-5387-1-git-send-email-linus.walleij@linaro.org>
References: <1395924553-5387-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140505035609.GA11035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 01:49:13PM +0100, Linus Walleij wrote:
> This moves the <mach/gpio.h> header in the AT91 platform down
> into the machine directory and removes the reliance on
> MACH_NEED_GPIO_H from the AT91.
> 
> This does not move the platform to GENERIC_GPIO but localize
> the remaining work to be done for this to the mach-at91
> folder.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This version is rebased on top of the timex-remove branch in
> the ARM SoC tree. I have done a few trial compilations with the
> defconfigs after rebasing but more may still be needed. IIRC
> one of the board files is now removed from the mainline kernel
> so there will be some simple merge conflict wherever it gets
> merged.
> 
> If you're happy with this I'd suggest applying it directly in
> the ARM SoC tree.

Looks like this one didn't make it for 3.15 given timing. Want to respin for
3.16 to handle the above conflicts and send to Nicolas?


-Olof
