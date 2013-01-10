From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 11:58:42 +0100
Subject: [PATCH v4 19/19] irqchip: Move ARM vic.h to
 include/linux/irqchip/arm-vic.h
In-Reply-To: <1357235668-9450-20-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-20-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZdR5YC7WEqQhxeNGbwreSnA2QmyRHFfeO1CncZSK6YVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 3, 2013 at 6:54 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have VIC moved to drivers/irqchip and all VIC DT init for
> platforms using irqchip_init, move gic.h and update the remaining
> includes.

This will need to be rebased on fixes merged for -rc3.

Apart from that, Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
