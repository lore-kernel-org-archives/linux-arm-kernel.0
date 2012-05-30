From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:18:54 +0800
Subject: [PATCH 21/22] ARM: ux500: Enable probing of pinctrl through
 Device Tree
In-Reply-To: <1338353260-10097-22-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-22-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZkOOP9aANBtqQ1CPFGNJ8WD5CWi2OmpF_2PdbiAEBy4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Nomadik GPIO controller now relies on Nomadik pinctrl, however
> the pinctrl driver is not currently started by any ux500 platform.
> This is requred or GPIOs do not work at all.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
