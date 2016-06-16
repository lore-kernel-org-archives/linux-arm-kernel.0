From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 Jun 2016 16:07:27 +0100
Subject: [PATCH v7 1/6] mfd: max8997: Use regmap to access registers
In-Reply-To: <57582C1F.5040306@samsung.com>
References: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
 <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
 <20160608142621.GG14888@dell> <57582C1F.5040306@samsung.com>
Message-ID: <20160616150727.GF4948@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jun 2016, Krzysztof Kozlowski wrote:

> On 06/08/2016 04:26 PM, Lee Jones wrote:
> > On Wed, 01 Jun 2016, Krzysztof Kozlowski wrote:
> > 
> >> From: Robert Baldyga <r.baldyga@samsung.com>
> >>
> >> This patch modifies max8997 driver and each associated function driver,
> >> to use regmap instead of operating directly on i2c bus. It will allow to
> >> simplify IRQ handling using regmap-irq.
> >>
> >> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> >> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>
> >> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Acked-by: Bryan Wu <cooloney@gmail.com>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >> Acked-by: Sebastian Reichel <sre@kernel.org>
> >> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> [k.kozlowski: Collect acks, rebase on v4.6-rc6]
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> >> ---
> >>  drivers/extcon/extcon-max8997.c       |  31 ++++----
> >>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
> >>  drivers/leds/leds-max8997.c           |  13 ++--
> >>  drivers/mfd/Kconfig                   |   1 +
> >>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
> >>  drivers/mfd/max8997.c                 | 141 +++++++++++++++-------------------
> >>  drivers/power/max8997_charger.c       |  33 ++++----
> >>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
> > 
> > Is it just Mark's Ack you require?
> 
> Yes, only Mark's is missing here. All other patches got everything they
> need.

I think you'd better re-submit and get Mark's attention.

Also indicate that his Ack is all you need.

Once received, I can take the set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
