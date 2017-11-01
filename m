From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 1 Nov 2017 06:57:22 +0100 (CET)
Subject: [PATCH 4/4] pinctrl: gemini: Implement clock skew/delay config
In-Reply-To: <20171028133719.27528-4-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
 <20171028133719.27528-4-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1711010656440.4454@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, 28 Oct 2017, Linus Walleij wrote:

> This enabled pin config on the Gemini driver and implements
> pin skew/delay so that the ethernet pins clocking can be
> properly configured.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/pinctrl/cortina,gemini-pinctrl.txt    |  10 +-
>  drivers/pinctrl/pinctrl-gemini.c                   | 178 ++++++++++++++++++++-
>  2 files changed, 182 insertions(+), 6 deletions(-)
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
