From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 8 May 2014 14:45:08 +0530
Subject: [PATCH v2 2/5] ARM: dts: enable fimd for exynos5250 based snow
 board
In-Reply-To: <002701cf6a8d$ef7b4540$ce71cfc0$%han@samsung.com>
References: <1399529995-8656-1-git-send-email-rahul.sharma@samsung.com>
 <1399529995-8656-3-git-send-email-rahul.sharma@samsung.com>
 <002701cf6a8d$ef7b4540$ce71cfc0$%han@samsung.com>
Message-ID: <CAPdUM4N-vYkN_hjT1oW_pXL83nMqFHv8ADohSVMLk9iSP_6bsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2014 12:50, Jingoo Han <jg1.han@samsung.com> wrote:
> On Thursday, May 08, 2014 3:20 PM, Rahul Sharma wrote:
>>
>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>
>> Enable fimd node for snow board.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250-snow.dts |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index 1ce1088..796954c 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -206,4 +206,10 @@
>>                       clock-frequency = <24000000>;
>>               };
>>       };
>> +
>> +     fimd at 14400000 {
>> +             status = "okay";
>
> (+cc Sachin Kamat, Tomasz Figa)
>
> For readability, how about moving 'status' to the last entry of
> the node? The same comment applies to other patches, too.
>

I just followed the nodes in rest of the file for peach and snow. This
looks consistent to me. But let me know if you want me to change
this.

Regards,
Rahul Sharma.

> Best regards,
> Jingoo Han
>
>> +             samsung,invert-vclk;
>> +     };
>> +
>>  };
>> --
>> 1.7.9.5
>
>
