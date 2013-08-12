From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Aug 2013 17:18:09 +0200
Subject: [PATCH] pinctrl: at91: choose appropriate handler for level
 interrupts
In-Reply-To: <CACRpkdaGdgLeYrahv0qAJJjL3S2aiZeVwRVUtNcDqQgL3_mQkA@mail.gmail.com>
References: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
 <CACRpkdaGdgLeYrahv0qAJJjL3S2aiZeVwRVUtNcDqQgL3_mQkA@mail.gmail.com>
Message-ID: <5208FCB1.9080009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2013 17:42, Linus Walleij :
> On Sat, Jul 20, 2013 at 4:51 PM, Boris BREZILLON
> <b.brezillon@overkiz.com> wrote:
>
>> The current implementation handle both edge and level interrupts with the
>> 'handle_simple_irq' handler.
>>
>> Level interrupts are active as long as the pin stays at the configured
>> level (low or high). In this case we have to use 'handle_level_irq' which
>> mask the interrupt until the handle has treated it.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>
> Nicolas/Jean-Christophe: any opinion on this patch?

Back online:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

(maybe too late though)

Thanks for fixing this.

Bye,

> I am tempted to just apply it and see if you react to it :-)
>
> Yours,
> Linus Walleij
>


-- 
Nicolas Ferre
