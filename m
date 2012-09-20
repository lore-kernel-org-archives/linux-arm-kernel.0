From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 08:34:20 +0200
Subject: [PATCH 1/1] ARM: ux500: Remove redundant #gpio-cell properties
 from Snowball DT
In-Reply-To: <1347983122-15174-1-git-send-email-lee.jones@linaro.org>
References: <1347983122-15174-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbX_FuZnX2J16UCD1KX-r55KU-st-Fv1AGZhionG6NM7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 5:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This property has no place here as the populated node is not related
> to a GPIO controller.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
