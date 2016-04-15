From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 15 Apr 2016 18:07:22 +0530
Subject: [PATCH] clk: samsung: exynos7: Don't gate CMU_{CCORE,
 FSYS0} blocks clock
In-Reply-To: <570F4BE0.1010102@samsung.com>
References: <1460608972-13878-1-git-send-email-alim.akhtar@samsung.com>
 <570F4BE0.1010102@samsung.com>
Message-ID: <5710E082.2050303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/14/2016 01:20 PM, Krzysztof Kozlowski wrote:
> On 04/14/2016 06:42 AM, Alim Akhtar wrote:
>> This patch adds CLK_IS_CRITICAL flag to ACLK_CCORE_133 and ACLK_FSYS0_200
>> clocks. These clocks are critical for accessing CMU_CCORE and CMU_FSYS0
>> blocks registers. Let these clocks to be enabled all the time.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos7.c |    5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
Thanks Krzysztof,
Sylwester, do you have any concern here?

> Best regards,
> Krzysztof
>
>
