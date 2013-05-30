From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:32:29 +0200
Subject: [PATCH 22/39] usb: musb: ux500: take the dma_mask from
 coherent_dma_mask
In-Reply-To: <1368611522-9984-23-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-23-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZo_ymcubrvm1k9+VKJq6ED-xOSv7V_Sry8ffhFB3RqyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The dma_mask will always be the same as the coherent_dma_mask, so let's
> cut down on the platform_data burden and set it as such in the driver.
> This also saves us from supporting it separately when we come to enable
> this driver for Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied with Felipe's ACK.

Yours,
Linus Walleij
