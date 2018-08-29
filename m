From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Aug 2018 17:23:17 +0200
Subject: [PATCH] clocksource: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-13-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-13-robh@kernel.org>
Message-ID: <ab53c967-c399-414e-86ef-daff04fbd56a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/2018 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied for 4.20

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
