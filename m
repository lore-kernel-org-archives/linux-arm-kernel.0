From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Jul 2018 18:02:33 +0200
Subject: [PATCH v3 04/23] thermal: armada: rename the initialization
 routine
In-Reply-To: <20180716144206.30985-5-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-5-miquel.raynal@bootlin.com>
Message-ID: <e371e6c4-7c74-f749-73cd-cc44434c9a6d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2018 16:41, Miquel Raynal wrote:
> Calling a hook ->init_sensor() while what is initialized is the IP
> itself and not the sensors is misleading. Rename the hook ->init() to
> avoid any confusion in later work bringing multi-sensors support.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
