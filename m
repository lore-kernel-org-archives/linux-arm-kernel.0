From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 11:22:16 +0200
Subject: [PATCH 14/28] ARM: SAMSUNG: Introduce GPIO_SAMSUNG Kconfig entry
In-Reply-To: <1371238384-1504-15-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
 <1371238384-1504-15-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdaJ9joD7rC_Rc_Jz5eocgtZFqYLRwGHwQp9FmNhVuBYtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 9:32 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch adds Kconfig entry that selects whether legacy Samsung GPIO
> driver should be built or not. For platforms that support only DT based
> boot, the new pinctrl driver is used and so the old one is not needed.
>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks good to me.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
