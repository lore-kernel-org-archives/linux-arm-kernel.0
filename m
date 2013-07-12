From: weisserm@arcor.de (=?ISO-8859-1?Q?Matthias_Wei=DFer?=)
Date: Fri, 12 Jul 2013 11:43:20 +0200
Subject: [PATCH] ARM: dts: imx25: Make lcdc compatible to imx27/imx21
 fb
In-Reply-To: <20130712084516.GI25501@S2101-09.ap.freescale.net>
References: <1373614495-21717-1-git-send-email-weisserm@arcor.de>
 <20130712084516.GI25501@S2101-09.ap.freescale.net>
Message-ID: <51DFCFB8.5050303@arcor.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.07.2013 10:45, schrieb Shawn Guo:
> On Fri, Jul 12, 2013 at 09:34:54AM +0200, Matthias Weisser wrote:
>> ARM: dts: imx25: Make lcdc compatible to imx27/imx21 fb
>>
>> Signed-off-by: Matthias Weisser <weisserm@arcor.de>
>> ---
>>  arch/arm/boot/dts/imx25.dtsi |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
>> index d2550e0..83532b6 100644
>> --- a/arch/arm/boot/dts/imx25.dtsi
>> +++ b/arch/arm/boot/dts/imx25.dtsi
>> @@ -377,7 +377,8 @@
>>  				status = "disabled";
>>  			};
>>
>> -			lcdc at 53fbc000 {
>> +			lcdc: lcdc at 53fbc000 {
>> +				compatible = "fsl,imx27-fb", "fsl,imx21-fb";
>
> It makes more sense to have it be:
>
> 	compatible = "fsl,imx25-fb", "fsl,imx21-fb";

Should I send a v2?

Matthias
