From: g.portay@overkiz.com (=?UTF-8?B?R2HDq2wgUE9SVEFZ?=)
Date: Thu, 04 Jun 2015 10:13:58 +0200
Subject: [PATCH] ARM: at91/dts: kizbox: fix mismatch LED PWM device
In-Reply-To: <55700621.4080900@atmel.com>
References: <1433324663-20208-1-git-send-email-g.portay@overkiz.com>
 <55700621.4080900@atmel.com>
Message-ID: <557008C6.60900@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 10:02, Nicolas Ferre wrote:
> Le 03/06/2015 11:44, Ga?l PORTAY a ?crit :
>> The network_red LED uses the 4th PWM device.
>>
>> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> And stacked on at91-4.2-dt.
>
> Bye,
>
>> ---
>>   arch/arm/boot/dts/at91-kizbox.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
>> index a0e63ff..cf1628f 100644
>> --- a/arch/arm/boot/dts/at91-kizbox.dts
>> +++ b/arch/arm/boot/dts/at91-kizbox.dts
>> @@ -205,7 +205,7 @@
>>
>>   		network_red {
>>   			label = "pwm:red:network";
>> -			pwms = <&tcb_pwm 3 10000000 PWM_POLARITY_INVERTED>;
>> +			pwms = <&tcb_pwm 4 10000000 PWM_POLARITY_INVERTED>;
>>   			max-brightness = <255>;
>>   			linux,default-trigger = "default-on";
>>   		};
>>
>
>

Thanks Nico
