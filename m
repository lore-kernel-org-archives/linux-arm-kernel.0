From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 25 May 2016 11:34:04 +0530
Subject: [PATCH] clk: samsung: exynos7: Don't gate CMU_{CCORE,
 FSYS0} blocks clock
In-Reply-To: <5711180A.8030809@samsung.com>
References: <1460608972-13878-1-git-send-email-alim.akhtar@samsung.com>
 <570F4BE0.1010102@samsung.com> <5710E082.2050303@samsung.com>
 <5711180A.8030809@samsung.com>
Message-ID: <57454054.1010001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 04/15/2016 10:04 PM, Sylwester Nawrocki wrote:
> On 04/15/2016 02:37 PM, Alim Akhtar wrote:
>> On 04/14/2016 01:20 PM, Krzysztof Kozlowski wrote:
>>>> On 04/14/2016 06:42 AM, Alim Akhtar wrote:
>>>>>> This patch adds CLK_IS_CRITICAL flag to ACLK_CCORE_133 and ACLK_FSYS0_200
>>>>>> clocks. These clocks are critical for accessing CMU_CCORE and CMU_FSYS0
>>>>>> blocks registers. Let these clocks to be enabled all the time.
>>>>>>
>>>>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>>>> ---
>>>>>>    drivers/clk/samsung/clk-exynos7.c |    5 +++--
>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>
>> Thanks Krzysztof,
>> Sylwester, do you have any concern here?
>
> I'm fine with the patch, if it fixes all the issues for you.
> I will apply it and will likely send it upstream after v4.7-rc1 release.
>
Looks like this patch is not available on your tree.
