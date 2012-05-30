From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:18:15 +0800
Subject: [PATCH 20/22] pinctrl-nomadik: Allow Device Tree driver probing
In-Reply-To: <1338353260-10097-21-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-21-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYax-8b_37WkmAhxBeBrxzt8P1dVsuFnCyxyDkrUbmX3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Nomadik GPIO controller now relies on Nomadik pinctrl, however
> the pinctrl driver is not currently started by any ux500 platform.
> This is requred or GPIOs do not work at all.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

And it seems reasonable to push for the -rc:s since it's
a consequence of parallell development up til the merge window.

Linus Walleij
