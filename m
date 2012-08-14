From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:19:43 +0200
Subject: [PATCH 3/8] ARM: ux500: Identify the PRCMU as an interrupt
 controller
In-Reply-To: <1344527635-6163-4-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYeo6jnVshj5n9kkBtj3ztxNUr-su6A9-ChQUqJaayhTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> We're just about to provide the DB8500-PRCMU with its own IRQ domain,
> so that its subordinate drivers can use it as an interrupt controller.
> It's obligatory for all IRQ controllers to reference themselves as
> such from its own node in Device Tree. This patch does just that.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
