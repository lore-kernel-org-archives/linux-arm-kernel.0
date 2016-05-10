From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 07:35:47 +0200
Subject: [PATCH v2 22/22] ARM: dts: exynos: Add initial support for Odroid
 XU board
In-Reply-To: <cbcb5657-8825-83cf-688f-d565ac7ecbab@osg.samsung.com>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-23-git-send-email-krzk@kernel.org>
 <cbcb5657-8825-83cf-688f-d565ac7ecbab@osg.samsung.com>
Message-ID: <57317333.5010309@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 12:02 AM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
>> The Hardkernel's Odroid XU board was first design with big.LITTLE SoC
>> from Samsung: the Exynos5410. Comparing now to more popular Odroid XU3
>> the differences are:
>> 1. Exynos5410 instead of 5422,
>> 2. DisplayPort,
>> 3. Main PMIC: Maxim 77802 instead of S2MPS11,
>> 4. USB3503+LAN9730 instead of integrated LAN9514,
>> 5. eMMC 4.5 instead of eMMC 5.0,
>>
>> This patch adds initial support for the XU board with working basic
>> functions, eMMC/SD and USB (including attached ethernet adapter).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
> 
> This DTS has some TODO's, FIXME's and commented input supplies. Probably
> this patch should had been an RFC? or you should mention about these in
> the commit message to understand why are there.

I have to clean it up or fix these notes. Actually I was quite surprised
that board worked fine with this basic setup.

Best regards,
Krzysztof
