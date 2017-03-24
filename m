From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 09:29:28 +0000
Subject: [PATCH 1/4 v2] irqchip: augment Gemini bindings to reflect
 Faraday origin
In-Reply-To: <20170318165326.20450-1-linus.walleij@linaro.org>
References: <20170318165326.20450-1-linus.walleij@linaro.org>
Message-ID: <604b75cd-e7ec-925d-e745-7ee7d45c602f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/17 16:53, Linus Walleij wrote:
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
> ChangeLog v1->v2:
> - No changes, just resending with the rest.

I've queued the series for 4.12.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
