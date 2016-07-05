From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 5 Jul 2016 12:03:29 +0200
Subject: [PATCH 3/6] Clocksource: add nuc970 clocksource driver
In-Reply-To: <577B6DFF.9000703@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-4-git-send-email-vw@iommu.org>
 <5771827E.1090609@linaro.org> <577B6DFF.9000703@iommu.org>
Message-ID: <577B85F1.9010004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 10:21 AM, Wan Zongshun wrote:

[ ... ]

>>> +    setup_irq(irq, &nuc970_timer0_irq);
>>
>> s/setup_irq/request_irq/
> 
> Do you think I should use request_irq instead of setup_irq?

Yes.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
