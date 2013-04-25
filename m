From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 14:02:58 +0200
Subject: [PATCH 7/9] ARM: ux500: Stop passing Cryp DMA channel config
 information though pdata
In-Reply-To: <1366280825-31136-8-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaXGGXvjakokLfXTrw5YmdGY9TNs1XO6XF370QQC4Z6Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:27 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA channel configuration information should be setup in the driver.
> The Ux500 Cryp driver now does this, so there's no need to send it
> though here too.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Provided the deps are in place:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
