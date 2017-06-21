From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 21 Jun 2017 09:51:48 +0200
Subject: [PATCH v5 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger edge
 type
In-Reply-To: <20170620175619.0a93d3d2@kernel.org>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
 <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
 <20170620175619.0a93d3d2@kernel.org>
Message-ID: <7183d5d8-1b2b-7188-6987-a578fa59cecb@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2017 at 18:56, Jonathan Cameron wrote:
> On Thu, 15 Jun 2017 16:24:56 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
>> Added ADTRG edge type property as interrupt edge type value
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Driver support heading upstream.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks,

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>> ---
>>   Changes in v4:
>>  - Modified bindings to be similar with interrupts
>>
>>  arch/arm/boot/dts/sama5d2.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index 8067c71..483a387 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -1267,6 +1267,7 @@
>>  				atmel,min-sample-rate-hz = <200000>;
>>  				atmel,max-sample-rate-hz = <20000000>;
>>  				atmel,startup-time-ms = <4>;
>> +				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
>>  				status = "disabled";
>>  			};
>>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Nicolas Ferre
