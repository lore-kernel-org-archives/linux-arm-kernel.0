From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 10 Dec 2014 11:04:33 +0100
Subject: [PATCH 1/2] ARM: at91/dt: sam9263: Fix typo: ac91_clk -> ac97_clk
In-Reply-To: <2676241.BfXNcaGQ7Q@kongar>
References: <1417789016-20001-1-git-send-email-alexanders83@web.de>
 <2676241.BfXNcaGQ7Q@kongar>
Message-ID: <54881AB1.3040609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/12/2014 16:00, Alexander Stein a ?crit :
> On Friday 05 December 2014, 15:16:55 wrote Alexander Stein:
>> That clock should be called ac97_clk.
>>
>> Signed-off-by: Alexander Stein <alexanders83@web.de>
>> ---
>>  arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
>> index 7989756..5ed2810 100644
>> --- a/arch/arm/boot/dts/at91sam9263.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
>> @@ -294,7 +294,7 @@
>>  						reg = <17>;
>>  					};
>>  
>> -					ac91_clk: ac97_clk {
>> +					ac97_clk: ac97_clk {
>>  						#clock-cells = <0>;
>>  						reg = <18>;
>>  					};
>>
> 
> Please ignore those 2 patches for now. I made a mistake during local rebase.

Well at least this one (1/2) is valid and applies on my new
at91-3.20-dt. So I take it for now: tell me if you feel otherwise.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,


> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Nicolas Ferre
