From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Jul 2016 20:38:22 -0700
Subject: [PATCH] clk: gxbb: expose CLKID_MMC_PCLK
In-Reply-To: <146784996534.73491.14217049599437131929@resonance> (Michael
 Turquette's message of "Wed, 06 Jul 2016 17:06:05 -0700")
References: <20160706230749.9620-1-khilman@baylibre.com>
 <146784996534.73491.14217049599437131929@resonance>
Message-ID: <m2y45ep175.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@baylibre.com> writes:

> Hi Kevin,
>
> Quoting Kevin Hilman (2016-07-06 16:07:49)
>> The MMC_PCLK is needed for the SD/eMMC driver.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  include/dt-bindings/clock/gxbb-clkc.h | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
>> index f889d80246cb..5eb69ec74f6b 100644
>> --- a/include/dt-bindings/clock/gxbb-clkc.h
>> +++ b/include/dt-bindings/clock/gxbb-clkc.h
>> @@ -8,5 +8,6 @@
>>  #define CLKID_CPUCLK           1
>>  #define CLKID_CLK81            12
>>  #define CLKID_ETH              36
>> +#define CLKID_MMC_PCLK         66
>
> I think you're missing removal of the duplicate macro as well:

Er, yup.  Re-spin coming right up.

Kevin
