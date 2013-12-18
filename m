From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 19 Dec 2013 03:06:24 +0900
Subject: [PATCH 3/3] ARM: dts: Fix MDMA0 clock number
In-Reply-To: <2082327.zpbOvCVe5P@amdc1227>
References: <1386817322-11265-1-git-send-email-a.kesavan@samsung.com>
 <1386817322-11265-3-git-send-email-a.kesavan@samsung.com>
 <2082327.zpbOvCVe5P@amdc1227>
Message-ID: <52B1E420.3080000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/13 23:49, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi,

> On Thursday 12 of December 2013 08:32:02 Abhilash Kesavan wrote:
>> Fix wrong clock number in mdma0 node.
>>
>> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5250.dtsi |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 9db5047..177becd 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -559,7 +559,7 @@
>>   			compatible = "arm,pl330", "arm,primecell";
>>   			reg =<0x10800000 0x1000>;
>>   			interrupts =<0 33 0>;
>> -			clocks =<&clock 271>;
>> +			clocks =<&clock 346>;
>>   			clock-names = "apb_pclk";
>>   			#dma-cells =<1>;
>>   			#dma-channels =<8>;
>>
>
> Can we have your ack for this patch?
>
Sure, please feel free to add my ack on this series.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> I'd like to apply the whole series into samsung-clk fixes branch and
> send a pull request to Mike to get it and one more fix into his tree.
>
I'm fine, thanks.

- Kukjin
