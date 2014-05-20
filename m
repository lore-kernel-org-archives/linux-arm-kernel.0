From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 16:17:22 +0100
Subject: [PATCH 5/7] mfd: twl4030-power: Add support for board specific
 configuration
In-Reply-To: <1400031250-29542-6-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-6-git-send-email-tony@atomide.com>
Message-ID: <20140520151722.GA24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Tony Lindgren wrote:

> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
> 
> Note that the data is private to this driver, and the data must
> always have a NULL resource in the sentinel.
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
>  include/linux/i2c/twl.h     |  1 +
>  2 files changed, 22 insertions(+)

Ah, I forgot to Ack this last time, didn't I?

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
