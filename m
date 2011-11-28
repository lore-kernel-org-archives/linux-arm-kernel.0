From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 10:09:08 +0100
Subject: [PATCH 2/7] gpio: make pxa gpio depend on pinmux
In-Reply-To: <1322262544-7854-3-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdag=P19j1QHGXqbFsKGS7Q9cDPgZP8QaGeF9R08Qm4gNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 12:08 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> From: Haojian Zhuang <hzhuang1@hexinfolabs.org>
>
> While gpio_request() is called, pinmux_request_gpio() would be called
> too. Then alternate function of pin can be changed to gpio directly.
>
> Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>

Looks good,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
