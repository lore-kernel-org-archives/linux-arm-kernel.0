From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 23:21:52 +0200
Subject: [PATCH 19/19] gpio: Enable the tc3298x GPIO expander driver for
 Device Tree
In-Reply-To: <1347016499-29354-20-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYVP_rseFOzxUS+pDnG3mfpNm4nExG7DH7sawZVVjUcig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we provide a means to probe and extract vital information
> from Device Tree when booting with it enabled. Without this
> patch sub-devices wouldn't be able to reference the tc3589x-gpio
> expander from Device Tree.
>
> CC: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied as well.

Yours,
Linus Walleij
