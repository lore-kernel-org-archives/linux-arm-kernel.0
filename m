From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 05:56:19 -0700
Subject: [PATCH 13/19] ARM: ux500: Stop registering I2C sub-devices for
 HREF when DT is enabled
In-Reply-To: <1347016499-29354-14-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYEXWbLN_HA98+HWu8HXH1Z=Sd_W=o5mnCxJJyJPMR_0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we remove all calls to register I2C sub-devices from platform
> code when Device Tree is enabled. Instead the I2C driver will parse
> the Device Tree for them.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(But you need the deps in place first, of course.)

Yours,
Linus Walleij
