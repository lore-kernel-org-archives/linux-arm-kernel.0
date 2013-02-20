From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 16:31:24 +0200
Subject: [PATCH v4 00/11] enhance DT support on gpio pxa
In-Reply-To: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5124DE3C.2050701@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/13 18:22, Haojian Zhuang wrote:
> Changelog:
> 
> v4:
> * Re-oragnize these patches.
> * Append document for new properties binding.
> * Discard the full support on irq domain. It will be appended in other
>   series.

Thanks Haojian.

I've tested these series on PXA3xx and PXA270 (non-DT configuration)
and it proved to be working - at least no new regressions are seen.
I've sent tested-bys to the relevant patches and IMHO this can be merged.

Linus, I wonder if you still can get this into 3.9?

> 
> v3:
> * Fix the gpio irq issue on legacy platform.
> * Discard irq_base & use irq domain instead in pxa_gpio_chip structure.
> * Update DTS file since it's depend on latest pinctrl single driver.
> 
> v2:
> * Fix the build issue without CONFIG_OF
> * Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
> * Use bool for inverted, ed_mask, gafr variable


-- 
Regards,
Igor.
