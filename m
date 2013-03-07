From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 09:09:58 +0100
Subject: [PATCH] mmc: sdhci-s3c: let device core setup the default pin
 configuration
In-Reply-To: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
References: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 12:36 PM, Thomas Abraham
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
