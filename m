From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:48:49 +0100
Subject: [PATCH v9 03/10] gpio: pl061: support irqdomain
In-Reply-To: <1361101376-3783-4-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZbF+ahCojEBhe49ubxJgh1Kt=akBZdhFUgpzG6AhdnVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Drop the support of irq generic chip. Now support irqdomain instead.
>
> Although set_wake() is defined in irq generic chip & it is not really
> used in pl061 gpio driver. Drop it at the same time.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Patch applied to my pinctrl tree to avoid clashes between the GPIO
and pinctrl trees later.

Yours,
Linus Walleij
