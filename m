From: jonas@orbital-systems.com (Jonas Danielsson)
Date: Mon, 5 Feb 2018 15:04:34 +0100
Subject: [PATCH] [PATCH] tty/serial: atmel: add new version check for usart
In-Reply-To: <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
References: <20180129113954.12011-1-jonas@orbital-systems.com>
 <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
Message-ID: <CALDOjziu=FBck-VSi=g=i8tcYWi_DQ_azzDnwKTkTuTrh54AkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 1:36 PM, Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
> On 29/01/2018 at 12:39, Jonas Danielsson wrote:
>> On our at91sam9260 based board the usart0 and usart1 ports report
>> their versions (ATMEL_US_VERSION) as 0x10302. This version is not
>> included in the current checks in the driver.
>>
>> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>
> It must be the AT91SAM9260 rev. B SoC, isn't it?
>
> Thanks for your patch.
>
> Best regards,
>   Nicolas
>

Hi Nicolas!

Thank you for the review!

Yes that is right, we have the rev B SoC :) I Tried to find some
documentation online
regarding the US_VERSION register, but fell short.

Allt the best
Jonas
