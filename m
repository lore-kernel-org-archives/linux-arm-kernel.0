From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:56:18 +0200
Subject: [PATCH 3/9] ARM: ux500: Stop passing Hash DMA channel config
 information though pdata
In-Reply-To: <1366280825-31136-4-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZoTD1J7pSfpO37Xhj6NPn86N7fK0zP_dimGYm=B3AUMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:26 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA channel configuration information should be setup in the driver.
> The Ux500 Hash driver now does this, so there's no need to send it
> though here too.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

When 2/9 is fixed up:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
