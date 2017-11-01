From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 1 Nov 2017 06:56:12 +0100 (CET)
Subject: [PATCH 2/4] pinctrl: Add skew-delay pin config and bindings
In-Reply-To: <20171028133719.27528-2-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
 <20171028133719.27528-2-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1711010655480.4454@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, 28 Oct 2017, Linus Walleij wrote:

> Some pin controllers (such as the Gemini) can control the
> expected clock skew and output delay on certain pins with a
> sub-nanosecond granularity. This is typically done by shunting
> in a number of double inverters in front of or behind the pin.
> Make it possible to configure this with a generic binding.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
