From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Sep 2015 14:51:43 +0900
Subject: [PATCH] arm64: dts: Add BUS1 instance pinctrl support
In-Reply-To: <55F6563A.2030107@samsung.com>
References: <1440761134-27639-1-git-send-email-alim.akhtar@samsung.com>
 <55E3E95D.50003@samsung.com> <55F6563A.2030107@samsung.com>
Message-ID: <55F6606F.3090000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 14:08, Alim Akhtar wrote:
> Hi
> 
> On 08/31/2015 11:12 AM, Krzysztof Kozlowski wrote:
>> On 28.08.2015 20:25, Alim Akhtar wrote:
>>> This adds BUS1 instance pinctrl for exynos7 soc.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  111
>>> +++++++++++++++++++++++
>>>   arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++
>>>   2 files changed, 118 insertions(+)
>>
>> The "etc1" GPIO in my datasheet is not fully documented but the rest
>> looks good:
>>
> Ok will send v2 and remove etc1 gpio node.

You don't have to. I mentioned it only for reference that I cannot
review the etc GPIO node because it is not mentioned in my datasheet.
However you may have different (e.g. newer) datasheet and etc1 could be
documented there.

I applied the first version of patch some time ago (your response is
after two weeks). Do you want me to replace it with v2?

Best regards,
Krzysztof
