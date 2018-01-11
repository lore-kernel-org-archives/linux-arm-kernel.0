From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:46:38 +0100
Subject: [PATCH 0/2] pinctrl: meson: use one uniform 'function' name
In-Reply-To: <20180108073328.205769-1-yixun.lan@amlogic.com>
References: <20180108073328.205769-1-yixun.lan@amlogic.com>
Message-ID: <CACRpkdZ6pW_3QTeQMGVbpa=1WTgR59fi+0aWCqmbRBzOn+F0cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 8, 2018 at 8:33 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> These two patches are general improvement for meson pinctrl driver.
> It make the two pinctrl trees (ee/ao) to share one uniform 'function' name for
> one hardware block even its pin groups live inside two differet hardware domains,
> which for example EE vs AO domain here.
>
> This idea is motivated by Martin's question at [1]
>
> [1]
>  http://lkml.kernel.org/r/CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw at mail.gmail.com

There seems to be controversy here so I'd like input from Carlo
and/or Beniamino if possible.

Yours,
Linus Walleij
