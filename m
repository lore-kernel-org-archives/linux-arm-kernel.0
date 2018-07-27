From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Jul 2018 18:09:18 +0200
Subject: [PATCH v3 05/23] thermal: armada: dissociate a380 and cp110
 ->init() hooks
In-Reply-To: <20180716144206.30985-6-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-6-miquel.raynal@bootlin.com>
Message-ID: <6b0ea6bf-df0b-94d2-c931-8fed66d5d3eb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2018 16:41, Miquel Raynal wrote:
> Until now, Armada 380 and CP110 could share the same ->init() function
> because their use was identical.
> 
> Prepare the support of multi-sensors support and overheat interrupt
> feature by separating the initialization paths before they actually
> diverge.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
