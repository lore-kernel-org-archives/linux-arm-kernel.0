From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 14 Sep 2015 10:38:10 +0530
Subject: [PATCH] arm64: dts: Add BUS1 instance pinctrl support
In-Reply-To: <55E3E95D.50003@samsung.com>
References: <1440761134-27639-1-git-send-email-alim.akhtar@samsung.com>
 <55E3E95D.50003@samsung.com>
Message-ID: <55F6563A.2030107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 08/31/2015 11:12 AM, Krzysztof Kozlowski wrote:
> On 28.08.2015 20:25, Alim Akhtar wrote:
>> This adds BUS1 instance pinctrl for exynos7 soc.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  111 +++++++++++++++++++++++
>>   arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++
>>   2 files changed, 118 insertions(+)
>
> The "etc1" GPIO in my datasheet is not fully documented but the rest
> looks good:
>
Ok will send v2 and remove etc1 gpio node.

> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
Thanks!!
> Best regards,
> Krzysztof
>
>
