From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:48:56 +0100
Subject: [PATCH 3/4] mfd: twl4030power: Add a configuration to turn off
 oscillator during off-idle
In-Reply-To: <1398300030-7386-4-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-4-git-send-email-tony@atomide.com>
Message-ID: <20140428114856.GX21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Some oscillators can be turned off during off-idle saving few
> a little bit power at the cost of the oscillator start up
> latency.
> 
> If you board can do this, you can now enable it by using the
> ti,twl4030-power-idle-osc-off compatible flag.
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt         |  6 ++++++
>  drivers/mfd/twl4030-power.c                           | 19 +++++++++++++++++++

Code in drivers/mfd looks scruffy but fine:
  Acked-by: Lee Jones <lee.jones@linaro.org>


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
