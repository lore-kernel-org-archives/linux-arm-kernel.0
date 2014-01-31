From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 31 Jan 2014 18:03:09 +0200
Subject: [PATCH] ARM: dts: k2hk-evm: rename clock node to clocks
In-Reply-To: <52EBB4F6.3050202@ti.com>
References: <1391175066-13862-1-git-send-email-grygorii.strashko@ti.com>
 <52EBB4F6.3050202@ti.com>
Message-ID: <52EBC93D.9000402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 04:36 PM, Santosh Shilimkar wrote:
> On Friday 31 January 2014 08:31 AM, Grygorii Strashko wrote:
>> Fix type in clock(s) node name: "clock"-->"clocks".
>>
> s/type/typo ;-)
>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
> No need to resend, I will fix it up while applying it

Thanks

>
>>   arch/arm/boot/dts/k2hk-evm.dts |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
>> index eaefdfe..c02c3a8 100644
>> --- a/arch/arm/boot/dts/k2hk-evm.dts
>> +++ b/arch/arm/boot/dts/k2hk-evm.dts
>> @@ -15,7 +15,7 @@
>>   	compatible =  "ti,keystone-evm";
>>
>>   	soc {
>> -		clock {
>> +		clocks {
>>   			refclksys: refclksys {
>>   				#clock-cells = <0>;
>>   				compatible = "fixed-clock";
>>
>
