From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 06:08:12 -0700
Subject: [PATCH 17/19] mfd: Enable the tc3589x for Device Tree
In-Reply-To: <1347016499-29354-18-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-18-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY43ms2CqTjbFo1KP6r2H23Zj1ivTd4fSYtjMO9sDWqwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we provide a means to probe and extract vital information
> from Device Tree when booting with it enabled. Without this
> patch sub-devices wouldn't be able to reference the tc3589x
> from Device Tree.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks like a good start (I guess all subdevices need to be
augmented too...) FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
