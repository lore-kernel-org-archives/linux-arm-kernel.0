From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 1 Nov 2017 06:56:41 +0100 (CET)
Subject: [PATCH 3/4] pinctrl: gemini: Use generic DT parser
In-Reply-To: <20171028133719.27528-3-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
 <20171028133719.27528-3-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1711010656180.4454@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sat, 28 Oct 2017, Linus Walleij wrote:

> We can just use the generic Device Tree parser code
> in this driver and save some code.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/Kconfig          |  1 +
>  drivers/pinctrl/pinctrl-gemini.c | 66 +++-------------------------------------
>  2 files changed, 5 insertions(+), 62 deletions(-)
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
