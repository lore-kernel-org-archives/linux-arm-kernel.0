From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 01:26:10 +0530
Subject: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
In-Reply-To: <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
Message-ID: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> add tmuctrl aliases node for exynos542x
>
> Please use full sentence, starting with capital letter and ending with
> a dot. Also please explain why you need tmuctrl aliases.
>

As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt

For multi-instance tmu each instance should have an alias correctly
numbered in "aliases" node.

>>
>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
>>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
>>  6 files changed, 32 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index 57c2332..ff79f0b 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -1061,19 +1061,19 @@
>>         status = "okay";
>>  };
>>
>> -&tmu_cpu0 {
>> +&tmu_cpu_0 {
>
> This looks irrelevant to the topic of adding aliases.
>

correct, I gone through the binding documentation and hence update this patch.

Best Regards
-Anand
