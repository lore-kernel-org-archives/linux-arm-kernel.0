From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 07:16:24 +0100
Subject: [PATCH] i2c: s3c24xx: allow device core to setup default pin
 configuration
In-Reply-To: <1362404573-30406-1-git-send-email-thomas.abraham@linaro.org>
References: <1362404573-30406-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdbyrecX=4sDsUDfGDErS_MeR22vmB7p_PA-TsfoE6runA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 4, 2013 at 2:42 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the call to devm_pinctrl_get_select_default can be removed. And
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is also removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
