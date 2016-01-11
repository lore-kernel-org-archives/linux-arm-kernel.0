From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 11 Jan 2016 13:04:35 -0300
Subject: [PATCH 2/2] ARM: exynos_defconfig: Enable s5p-secss driver
In-Reply-To: <CAJKOXPdie=mAPFxdnn_Ue+kNVTKQ1bFJigti35JMz7hmkYJ9cw@mail.gmail.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
 <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
 <568FD733.8030601@osg.samsung.com>
 <CAJKOXPdie=mAPFxdnn_Ue+kNVTKQ1bFJigti35JMz7hmkYJ9cw@mail.gmail.com>
Message-ID: <5693D293.2050101@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/08/2016 11:46 PM, Krzysztof Kozlowski wrote:

[snip]

>>> --- a/arch/arm/configs/exynos_defconfig
>>> +++ b/arch/arm/configs/exynos_defconfig
>>> @@ -240,6 +240,7 @@ CONFIG_DEBUG_RT_MUTEXES=y
>>>  CONFIG_DEBUG_SPINLOCK=y
>>>  CONFIG_DEBUG_MUTEXES=y
>>>  CONFIG_DEBUG_USER=y
>>> +CONFIG_CRYPTO_DEV_S5P=y
>>
>> I noticed that this is not enabled in multi_v7_defconfig.
>> Are you planing to do it as well?
> 
> Thanks for feedback and review. I noticed that as well but I am not
> convinced because one of two of supported algorithms fails the
> tests... which makes 50% of driver non-working. :) Maybe it is
> harmless - just pollutes the dmesg... Maybe after fixing it.
>

Agreed that can be done after fixing the driver.
 
> Best regards,
> Krzysztof

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
