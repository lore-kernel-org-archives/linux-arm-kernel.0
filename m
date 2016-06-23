From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jun 2016 10:49:22 +0200
Subject: [PATCH] pinctrl: rockchip: make rockchip_irq_gc_mask_set_bit
 static
In-Reply-To: <1466530701-26685-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466530701-26685-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdZuGXGcZsGVu2bA28_CgUAjmoyC1m46jHxHmQNbcHO94w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 7:38 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The rockchip_irq_gc_mask_set_bit() function is not exported our used
> outside of ppinctrl-rockchip.c so fix the following sparse error by
> making it static:
>
> drivers/pinctrl/pinctrl-rockchip.c:2010:6: warning: symbol 'rockchip_irq_gc_mask_set_bit' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Patch applied as obviously correct.

Yours,
Linus Walleij
