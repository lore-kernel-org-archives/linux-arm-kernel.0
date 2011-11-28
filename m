From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 10:18:25 +0100
Subject: [PATCH 3/7] ARM: pxa: enable pinmux in pxa pwm
In-Reply-To: <1322262544-7854-4-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbQEHjwF0mAJf3hCX7VdW0YBcHH0z6dFus-rC09_e08vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 12:09 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> From: Haojian Zhuang <hzhuang1@hexinfolabs.org>
>
> Add pinmux operations in pxa pwm driver.
>
> Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>

Same comment as for the serial driver,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I need one of the PXA maintainers (Eric, Russell) ACK to merge
it through the pinctrl tree.

Thanks,
Linus Walleij
