From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:14:06 +0200
Subject: [PATCH 04/11] ARM: davinci: da8xx: creation of gpio platform
 device
In-Reply-To: <1369206634-6778-5-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-5-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdaKjfyJWbr3HjHWCeFPeg0mrwDZ+G7Fn_y8Z_PGg2JM2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> From: KV Sujith <sujithkv@ti.com>
>
> gpio controller resource information being associated with
> davinci_soc_info structure and not created any device. Hence davinci
> gpio didn't fall under proper device model. This patch creates gpio
> davinci as a platform device for da8xx platforms.
>
> - Add Memory and IRQ resources for DA8xx.
> - Register GPIO platform driver for DA8xx.
> - Add da8xx_register_gpio API to create platform device for da8xx
>   platforms.
>
> Signed-off-by: KV Sujith <sujithkv@ti.com>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
