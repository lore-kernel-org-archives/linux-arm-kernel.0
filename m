From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 19 Mar 2017 11:21:01 +0100 (CET)
Subject: [PATCH 1/4 v2] irqchip: augment Gemini bindings to reflect
 Faraday origin
In-Reply-To: <20170318165326.20450-1-linus.walleij@linaro.org>
References: <20170318165326.20450-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1703191119020.5783@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sat, 18 Mar 2017, Linus Walleij wrote:

> When we merged the Gemini interrupt controller it was not yet
> discovered that this IP block is actually a standard Faraday
> Technology interrupt controller.
> 
> As the IP block will probably appear in other designs as well,
> let's augment the DT bindings to reflect that it is first and
> foremost a standard Faraday part with a function name (FTINTC010)
> so that people reusing the IP easily find the driver they need.
> 
> Sorry for the mistakes due to lack of information.
> 
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

You can add my

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

on the whole series, if you want.

Greetings form Cologne
Hans Ulli Kroll
