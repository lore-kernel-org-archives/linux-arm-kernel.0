From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 30 Apr 2014 16:07:50 +0530
Subject: [PATCH 3/4] ARM: dts: Add usb2phy support on exynos5420
In-Reply-To: <5360CF8A.5010809@gmail.com>
References: <1398848110-6152-1-git-send-email-gautam.vivek@samsung.com>
 <1398848110-6152-4-git-send-email-gautam.vivek@samsung.com>
 <5360CF8A.5010809@gmail.com>
Message-ID: <CAFp+6iGDoMQO2-BMdOJjnjnb6_cO1VUTLX2MjRksHmPqYTEq9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,


On Wed, Apr 30, 2014 at 3:55 PM, Arun Kumar K <arunkk.samsung@gmail.com> wrote:
> Hi Vivek,
>
> On 04/30/14 14:25, Vivek Gautam wrote:
>> Add required device node for usb2phy to let enable USB 2.0
>> support.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index cfa3755..16b860a 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -737,4 +737,14 @@
>>               clock-names = "secss";
>>               samsung,power-domain = <&g2d_pd>;
>>       };
>> +
>> +     phy at 12130000 {
>
> As we will be changing over to reference-based updation of nodes in the
> board dts files, it would be good to add node reference also while
> adding new nodes. Like : usb_phy: phy at 12130000 {

Sure, i will add node-references to phy as well as the usb nodes in
the subsequent patch.

[snip]


-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
