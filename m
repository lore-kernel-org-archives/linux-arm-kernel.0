From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jun 2010 15:09:12 +0200
Subject: [PATCH] MAINTAINERS: some Atmel drivers change maintainer
In-Reply-To: <4C1B518F.4090307@ru.mvista.com>
References: <1276694487-20065-1-git-send-email-nicolas.ferre@atmel.com>
	<4C1B518F.4090307@ru.mvista.com>
Message-ID: <4C1B6FF8.1060504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/06/2010 12:59, Sergei Shtylyov :
> Hello.
> 
> Nicolas Ferre wrote:
> 
>> I take over the maintenance of SPI, USART, Ethernet and USB gadget
>> drivers.
>> Those drivers are found in Atmel microcontrollers, both AT32/AVR32 and
>> AT91/ARM.
> 
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
>> ---
>>  MAINTAINERS |   10 +++++-----
>>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6d119c9..5f71809 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1148,7 +1148,7 @@ F:    drivers/mmc/host/atmel-mci.c
> [...]
>>  ATMEL USBA UDC DRIVER
>> -M:    Haavard Skinnemoen <hskinnemoen@atmel.com>
>> -L:    kernel at avr32linux.org
>> +M:    Nicolas Ferre <nicolas.ferre@atmel.com>
>> +L:    linux-arm-kernel at lists.infradead.org (moderated for
>> non-subscribers)
> 
>    Not linux-usb at vger.kernel.org?

The problem is that I am not subscribing to it at the moment...
Maybe I should add it to the USBA driver entry...

Best regards,
-- 
Nicolas Ferre
