From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Mar 2014 11:52:02 +0100
Subject: [PATCH 0/3] iio: adc: at91 fixes
In-Reply-To: <531823BB.4080106@atmel.com>
References: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
 <531823BB.4080106@atmel.com>
Message-ID: <531D9952.5070405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 08:28, Josh Wu :
> Hi, Alexandre
> 
> On 3/6/2014 12:57 AM, Alexandre Belloni wrote:
>> This series fixes a kernel crash at probe time when using the at91_adc driver
>> through platform_data. This crash appeared in 3.13.
>>
>> The first patch fixes the crash. While it is already quite late, I think it
>> would be good to get it in 3.14.
>>
>> The next patches restore support for at91_adc on the at91sam9g45 and at91sam9260
>> based boards. It would be great if they could make it in 3.14. But I'm not sure
>> it is worth applying them to 3.13.
>>
>> Alexandre Belloni (3):
>>    iio: adc: at91_adc: Repair broken platform_data support
>>    ARM: at91: at91sam9g45: change at91_adc name
>>    ARM: at91: at91sam9260: change at91_adc name
>>
>>   arch/arm/mach-at91/at91sam9260_devices.c |  2 +-
>>   arch/arm/mach-at91/at91sam9g45_devices.c |  2 +-
>>   drivers/iio/adc/at91_adc.c               | 26 ++++++++++++++++++++++----
>>   3 files changed, 24 insertions(+), 6 deletions(-)
>>
> 
> Thank you for the fixes.
> I tested the patch series in at91sam9m10g45ek and works fine.
> 
> so here is my:
> Tested-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Josh Wu <josh.wu@atmel.com>

Ok, fine with me:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


-- 
Nicolas Ferre
