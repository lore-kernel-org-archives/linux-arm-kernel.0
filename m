From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:41:31 +0200
Subject: [PATCH 12/14] ARM: ux500: Correctly reference IRQs supplied by
 the AB8500 from Device Tree
In-Reply-To: <1339428307-3850-13-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbJ_3Br=RbfbNRBrtz6zc3MH_B6f9E-2aQk=XhMHPnnrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The AB8500 driver has now been provided with IRQ domain support. This
> means we can request IRQs from any of it's uses via Device Tree. This
> patch advertises the AB8500 as an Interrupt Controller and provides the
> correct calls in the format the driver expects.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
