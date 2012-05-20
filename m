From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 May 2012 22:53:41 +0200
Subject: [PATCH 01/18] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <1337262323-27692-2-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZFZCvK_Dt4HvxPrVNU6UN7YPm3xY_kPruaGCGuX2CM0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 3:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we move the i2c-nomadik's default settings into the driver
> rather than specifying them from platform code. At the time of
> this writing we only have one user, the u8500. As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
>
> Cc: linux-i2c at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Nice!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

BTW: you want to CC Wolfram on the I2C patches.

Yours,
Linus Walleij
