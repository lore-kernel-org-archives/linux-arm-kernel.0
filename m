From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:08:28 +0200
Subject: [PATCH] pinctrl: sh-pfc: fix warnings by include core.h
In-Reply-To: <1465320786-10333-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465320786-10333-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdaq8jzBT8o8RVnnA6xQ1YVqFoYf+wgmrWciJx0qbDLs=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 7:33 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> Fix warnings about emev2_pinmux_info and r8a7779_pinmux_info
> by using core.h instead of sh_pfc.h in these files. This gives
> the declarations of the two structures and removes the following
> warnings:
>
> drivers/pinctrl/sh-pfc/pfc-emev2.c:1695:30: warning: symbol 'emev2_pinmux_info' was not declared. Should it be static?
> drivers/pinctrl/sh-pfc/pfc-r8a7779.c:3888:30: warning: symbol 'r8a7779_pinmux_info' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Geert/Laurent:

- take a look at this patch
- shall I apply this directly?

Yours,
Linus Walleij
