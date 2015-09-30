From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 30 Sep 2015 15:20:16 +0800
Subject: [PATCH v5 07/17] ARM: dts: exynos/dp: remove some properties
 that deprecated by analogix_dp driver
In-Reply-To: <560B7584.8070703@samsung.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <1442907799-6266-1-git-send-email-ykk@rock-chips.com>
 <560B7584.8070703@samsung.com>
Message-ID: <560B8D30.2010309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 09/30/2015 01:39 PM, Krzysztof Kozlowski wrote:
> On 22.09.2015 16:43, Yakir Yang wrote:
>> After exynos_dp have been split the common IP code into analogix_dp driver,
>> the analogix_dp driver have deprecated some Samsung platform properties which
>> could be dynamically parsed from EDID/MODE/DPCD message, so this is an update
>> for Exynos DTS file for dp-controller.
>>
>> Beside the backward compatibility is fully preserved, so there are no
>> bisectability break that make this change in a separate patch.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v5:
>> - Correct the misspell in commit message. (Krzysztof)
>>
>> Changes in v4:
>> - Separate all DTS changes to a separate patch. (Krzysztof)
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   arch/arm/boot/dts/exynos5250-arndale.dts   | 2 --
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts  | 2 --
>>   arch/arm/boot/dts/exynos5250-snow.dts      | 4 +---
>>   arch/arm/boot/dts/exynos5250-spring.dts    | 4 +---
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 +---
>>   arch/arm/boot/dts/exynos5420-smdk5420.dts  | 2 --
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 +---
>>   7 files changed, 4 insertions(+), 18 deletions(-)
>>
> Assuming this will be merged as part of this set (dependency on previous
> patches):
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks a lot ;)

- Yakir

> Best regards,
> Krzysztof
>
>
>
>
