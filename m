From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Feb 2013 14:33:03 +0100
Subject: [PATCH v8 01/12] gpio: add gpio offset in gpio range cells
 property
In-Reply-To: <1360602659-4774-2-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdby1fc8qKCYUREB8uhCHXAok=4NPxd6AetHGEYNJZuCUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add gpio offset into "gpio-range-cells" property. It's used to support
> sparse pinctrl range in gpio chip.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Seems reasonable to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

However I want Grant to have the final say on this patch.

Yours,
Linus Walleij
