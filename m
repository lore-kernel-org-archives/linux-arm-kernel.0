From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:41:33 +0100
Subject: [PATCH 1/4] mfd: twl4030-power: Add recommended idle configuration
In-Reply-To: <1398300030-7386-2-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
Message-ID: <20140428114133.GV21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> These settings are based on the "Recommended Sleep Sequences for
> the Zoom Platform" pdf at:
> 
> http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
> 
> These settings assume most of the regulators are under control of
> Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> do it.

Linux does it becuase Linux can't do it. Eh?

> For any board specific changes to these, let's patch them in as
> changes to the generic data in the follow-up patches. This keeps
> the board specific changes small.
> 
> Note that this does not consider the twl5030 errata 27. That
> can be added later on after it has been tested.
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |   4 +
>  drivers/mfd/twl4030-power.c                        | 165 +++++++++++++++++++++

driver/mfd changes look good to me:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
