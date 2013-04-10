From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Apr 2013 23:01:27 +0200
Subject: [PATCH 2/3] ARM: pxa: move PXA_GPIO_TO_IRQ macro
In-Reply-To: <1365556707-9159-2-git-send-email-haojian.zhuang@linaro.org>
References: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
 <1365556707-9159-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYJqyhYRn-xQ_R1ca+4mHpJYQduRXPnj4pgQV+zK_EdOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 3:18 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() macro are depended on
> arch code, move them from gpio driver to platform driver instead.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
