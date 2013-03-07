From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 09:13:44 +0100
Subject: [PATCH] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdaDLn3mQHhf3iUwFaEXyT1DJc8JzgR2UteQhZqjaPA0xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 1:04 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
