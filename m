From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 20 Apr 2014 12:36:36 -0700
Subject: [RESEND: PATCH 2/2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <1397028491-15462-1-git-send-email-linus.walleij@linaro.org>
References: <1397028491-15462-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140420193636.GG12454@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 09:28:11AM +0200, Linus Walleij wrote:
> Implement device tree probing for the tc3589x keypad driver.
> This is modeled on the STMPE keypad driver and tested on the
> Ux500 TVK1281618 UIB.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Use two local u32 variables to avoid weirdness in u8 casting
>   of the resulting values to the pointers.
> ChangeLog v1->v2:
> - Fix rows/columns binding to read two u32's insead of two
>   u8 /bits/ as noted by Mark Rutland.

Applied, thank you.

-- 
Dmitry
