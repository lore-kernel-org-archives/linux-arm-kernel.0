From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 15:38:04 +0100
Subject: [PATCH v2 1/2] at91: gpio: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <52EB657A.4040601@atmel.com>
References: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>	<1390473478-5591-2-git-send-email-jjhiblot@traphandler.com>
 <CACRpkdZ4LxkRERfD-prZvJSOZyomgf8v8P+vLhb_+hrSkL8rzg@mail.gmail.com>
 <52EB657A.4040601@atmel.com>
Message-ID: <5320714C.3050306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/2014 09:57, Nicolas Ferre :
> On 31/01/2014 08:55, Linus Walleij :
>> On Thu, Jan 23, 2014 at 11:37 AM, Jean-Jacques Hiblot
>> <jjhiblot@traphandler.com> wrote:
>>
>>> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
>>> the gpiolib so we can keep track of the usage centrally.
>>>
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Nicolas, are you queueing this patch?
> 
> Yes, I will.

stacked on at91-3.15-cleanup branch.

Best regards,

>> I guess this custom GPIO implementation is going away with
>> the transition to pinctrl else I'd requested that it be moved to
>> drivers/gpio...
> 
> Absolutely. But I suspect it will still be around for some time...
> 
> Thanks for your review. Bye,
> 


-- 
Nicolas Ferre
