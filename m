From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:04:01 +0200
Subject: [PATCH 03/10] usb: musb: ux500: take the dma_mask from
 coherent_dma_mask
In-Reply-To: <1366729394-11406-4-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZv8b7F6XotTUriP1hOgtabBpCUPyU6D9nYSZQU8x431w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 5:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The dma_mask will always be the same as the coherent_dma_mask, so let's
> cut down on the platform_data burden and set it as such in the driver.
> This also saves us from supporting it separately when we come to enable
> this driver for Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And makes it way more readable too!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
