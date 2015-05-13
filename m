From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 09:47:23 +0900
Subject: [GIT PULL] ARM: EXYNOS: dts: DTS fixes for 4.1, second try
In-Reply-To: <5552461A.6070304@kernel.org>
References: <1431313819-16843-1-git-send-email-k.kozlowski@samsung.com>
 <5552461A.6070304@kernel.org>
Message-ID: <55529F1B.3050703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.2015 03:27, Kukjin Kim wrote:
> On 05/11/15 12:10, Krzysztof Kozlowski wrote:
>> Dear Kukjin,
>>
>> This groups one fix missed in your last pull requst. This fixes suspend
>> on Peach boards related to Marvell mwifiex driver. The driver was
>> enabled for Exynos defconfig during merge window so currently
>> the suspend on these boards on this config fails.
>>
> Yes, you're right. Only exynos5250-snow related patch has been fixed
> before and this should be sent to upstream together. I've applied this
> into samsung-fixes-2 with your signed-off-by.
> 
> Note this will be sent to arm-soc before a couple of days of -rc4 with
> your other fix for suspend on exynos4.

Great, thank you!

What about the patches for next release (v4.2 or v4.3)? Do you have any
comments on them? These are mostly small improvements except one: the
coupled cpuidle driver for Exynos3250.

Best regards,
Krzysztof
