From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 22 May 2014 14:12:23 +0200
Subject: [PATCHv4 0/3] clocksource: Add Freescale FlexTimer Module (FTM)
 timer support
In-Reply-To: <1400492168-12813-1-git-send-email-Li.Xiubo@freescale.com>
References: <1400492168-12813-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <537DE9A7.7090606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2014 11:36 AM, Xiubo Li wrote:
> Changes in V4:
> - Add struct ftm_clock_device {} support.
> - peroidic_cyc --> periodic_cyc.
>
> Changes in V3:
> - Fix the ftm_irq_disable.
>
> Changes in V2:
> - Add big-endian support.
> - Add using pr_err instead of BUG_ON.
> - Add more detail comment message of FTM.
> - Add DT binding documentation.
> - Remove some header files and macros not useful.

DTS binding guys,

any comment on the patches ?

Thanks
   -- Daniel




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
