From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:53:50 +0200
Subject: [PATCH 08/15] ARM: ux500: PRCMU related configuration and layout
 corrections for Device Tree
In-Reply-To: <1336155805-18554-9-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Apply db8500 related PRCMU Device Tree settings and clean up some formatting
> errors. We also remove one of the PRCMU assigned IRQs, as it is currently not
> used.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
(...)
> - ? ? ? ? ? ? ? ? ? ? ? interrupts = <46 47>;
> + ? ? ? ? ? ? ? ? ? ? ? interrupts = <0 47 0x4>;

Sorry I don't get it, why is two values in decimal and one in hex?

Please choose one and stick to it...

Yours,
Linus Walleij
