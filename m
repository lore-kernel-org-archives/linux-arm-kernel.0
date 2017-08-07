From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 11:05:56 +0200
Subject: [PATCH] pinctrl-st: fix of_irq_to_resource() result check
In-Reply-To: <20170729180744.873303067@cogentembedded.com>
References: <20170729180744.873303067@cogentembedded.com>
Message-ID: <CACRpkdbLTr+zcwXaanr2HJHp=e-AauDx_hZ=dd4zjmAKsRdOtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 8:07 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> of_irq_to_resource() has recently been fixed to return negative error #'s
> along with 0 in case of failure, however the ST driver still only regards
> 0 as failure indication -- fix it up.
>
> Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Patch applied.

Yours,
Linus Walleij
