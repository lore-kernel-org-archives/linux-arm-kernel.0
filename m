From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 16 Feb 2018 10:27:50 +0100
Subject: [PATCH] [PATCH] tty/serial: atmel: add new version check for usart
In-Reply-To: <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
References: <20180129113954.12011-1-jonas@orbital-systems.com>
 <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
Message-ID: <CACQ1gAjs1VwaVdnimDcyD9ZgxC6ei6oap-d9Fma14G9V6iw19g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-05 13:36 GMT+01:00 Nicolas Ferre <nicolas.ferre@microchip.com>:
> On 29/01/2018 at 12:39, Jonas Danielsson wrote:
>> On our at91sam9260 based board the usart0 and usart1 ports report
>> their versions (ATMEL_US_VERSION) as 0x10302. This version is not
>> included in the current checks in the driver.
>>
>> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>

Acked-by: Richard Genoud <richard.genoud@gmail.com>

> It must be the AT91SAM9260 rev. B SoC, isn't it?
>
> Thanks for your patch.
>
> Best regards,
>   Nicolas

Thanks !

Richard.
