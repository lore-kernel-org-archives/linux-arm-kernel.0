From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Jan 2015 13:55:23 +0900
Subject: [PATCH v3] ARM: exynos_defconfig Enable CONFIG_LOCKUP_DETECTOR.
In-Reply-To: <1421137088.8355.1.camel@AMDC1943>
References: <1421088614-4662-1-git-send-email-moon.linux@yahoo.com>
 <1421137088.8355.1.camel@AMDC1943>
Message-ID: <54C325BB.1010904@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/15 17:18, Krzysztof Kozlowski wrote:
> On wto, 2015-01-13 at 00:20 +0530, Anand Moon wrote:
>> On enabling CONFIG_LOCKUP_DETECTOR the kernel to act as a watchdog
>> to detect hard and soft lockups. Enabling CONFIG_LOCKUP_DETECTOR
>> don't introduce much overhead on exyons SOC.
>>
>> CONFIG_LOCKUP_DETECTOR is enabled on multi_v7_defconfig.
>>
>> Changes since v3:
>>  * Made commit message more clear
>>  * Corrected difference between CONFIG_LOCKUP_DETECTOR and CONFIG_LOCKDEP.
>>
>> Tested on Exynos5422 ODROID XU3 board.
>>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Anand Moon <moon.linux@yahoo.com>
> 
> Now it looks okay. My reviewed-by may stay on.
> 
Thanks, applied

- Kukjin
