From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Sep 2012 21:57:26 +0200
Subject: [PATCH 7/6] pinctrl: exynos: Fix wakeup IRQ domain registration
 check
In-Reply-To: <2737662.uE6StcAj33@amdc1227>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
 <2737662.uE6StcAj33@amdc1227>
Message-ID: <CACRpkdYkVicrUk-H2Tx=tCDRxquq2B=n6O5UNZ8QoXLfMEDV=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 4:53 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> Because of a typo, incorrect field of a structure was being checked.
> This patch fixes the check to use correct field.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume you'll take this through the Samsung tree.

Yours,
Linus Walleij
