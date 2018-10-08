From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 8 Oct 2018 07:54:49 +0200
Subject: [PATCH 01/13] clocksource: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <2157c9c6-90fe-d77a-fac0-0f88ed4c9e49@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5.10.2018 16:35, Daniel Lezcano wrote:
> From: Rob Herring <robh@kernel.org>
> 
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/asm9260_timer.c       | 2 +-
>  drivers/clocksource/cadence_ttc_timer.c   | 2 +-

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
