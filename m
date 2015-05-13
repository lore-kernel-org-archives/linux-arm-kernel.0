From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Wed, 13 May 2015 18:42:16 +0900
Subject: [PATCH v4 01/13] ARM: dts: Add labels to Exynos4 nodes
In-Reply-To: <5553125A.6090404@kernel.org>
References: <1431351773-2031-1-git-send-email-k.kozlowski.k@gmail.com>
 <1431351773-2031-2-git-send-email-k.kozlowski.k@gmail.com>
 <5553125A.6090404@kernel.org>
Message-ID: <CAJKOXPfUVKvFTSgCdK4rpeGDe7oDwP3-dViXxwtXiQ-vSpCKSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-13 17:59 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
> On 05/11/15 22:42, Krzysztof Kozlowski wrote:
>> Add new labels to certain nodes so they could be easily referenced by
>> Exynos4 board DTS files.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos4.dtsi            | 22 +++++++++++-----------
>>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  6 +++---
>>  arch/arm/boot/dts/exynos4210.dtsi         |  6 +++---
>>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |  8 ++++----
>>  arch/arm/boot/dts/exynos4x12.dtsi         |  2 +-
>>  5 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
>> index 1c74c1296ab7..0ec292d25b6e 100644
>> --- a/arch/arm/boot/dts/exynos4.dtsi
>> +++ b/arch/arm/boot/dts/exynos4.dtsi
>
> [...]
>
>> diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>> index a7c212891674..4704e7bb2628 100644
>> --- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>> @@ -15,7 +15,7 @@
>>  */
>>
>>  / {
>> -     pinctrl at 11400000 {
>> +     pinctrl_0: pinctrl at 11400000 {
>>               gpa0: gpa0 {
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>> @@ -421,7 +421,7 @@
>>               };
>>       };
>>
>> -     pinctrl at 11000000 {
>> +     pinctrl_1: pinctrl at 11000000 {
>>               gpj0: gpj0 {
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>> @@ -822,7 +822,7 @@
>>               };
>>       };
>>
>> -     pinctrl at 03860000 {
>> +     pinctrl_3: pinctrl at 03860000 {
>
> Maybe,
> +       pinctrl_2: pinctrl at 03860000 { ?
Yes, you are right. Actually I made mistake here because in
exynos4210.dtsi these labels are defined.

I will fix it and re-spin.

Thanks for feedback,
Krzysztof
