From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Jul 2018 18:03:08 +0200
Subject: [PATCH v3 03/23] thermal: armada: remove misleading comments
In-Reply-To: <20180716144206.30985-4-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-4-miquel.raynal@bootlin.com>
Message-ID: <ed966280-9200-4993-268d-61096ed41807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2018 16:41, Miquel Raynal wrote:
> On older versions of this thermal IP, TSEN referred as the internal
> sensor in the thermal IP while EXT_TSEN referred as sensors outside of
> this IP, ie in the CPUs most of the time. The bit names in the
> specifications do not follow this rule anymore, so remove these comments
> that are misleading.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
