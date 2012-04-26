From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2012 23:36:52 +0200
Subject: [PATCH 1/2] pinctrl: support gpio request deferred probing
In-Reply-To: <1335353894-22096-1-git-send-email-b29396@freescale.com>
References: <1335353894-22096-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdadLsqpb=X+BmomyRywf=SrgGpbW2B=Myo3zTn_xMHJ2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 1:38 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> As pinctrl handles, it may be possible the pinctrl gpio ranges
> are still not got registered when user call pinctrl_gpio_request.
> Thus, add defer support for it too.
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Since nobody is saying anything and it looks reasonable,
I just applied this.

Thanks!
Linus Walleij
