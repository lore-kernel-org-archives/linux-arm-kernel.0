From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 11:17:08 +0100
Subject: [PATCH v2 1/2] at91: gpio: use gpiolib API to mark a GPIO used as
 an IRQ
In-Reply-To: <53209976.80008@atmel.com>
References: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>
 <1390473478-5591-2-git-send-email-jjhiblot@traphandler.com>
 <CACRpkdZ4LxkRERfD-prZvJSOZyomgf8v8P+vLhb_+hrSkL8rzg@mail.gmail.com>
 <52EB657A.4040601@atmel.com> <5320714C.3050306@atmel.com>
 <53209976.80008@atmel.com>
Message-ID: <CACRpkdYXtiZNSAAZxWgmPb2kNoe07nfvc2LmYXAPfTjoefsGrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 6:29 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 12/03/2014 15:38, Nicolas Ferre :
>> On 31/01/2014 09:57, Nicolas Ferre :
>>> On 31/01/2014 08:55, Linus Walleij :
>>>> On Thu, Jan 23, 2014 at 11:37 AM, Jean-Jacques Hiblot
>>>> <jjhiblot@traphandler.com> wrote:
>>>>
>>>>> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
>>>>> the gpiolib so we can keep track of the usage centrally.
>>>>>
>>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>>
>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> Nicolas, are you queueing this patch?
>>>
>>> Yes, I will.
>>
>> stacked on at91-3.15-cleanup branch.
>
> ... And immediately removed thanks to Boris' advice: it seems that you
> will move to a gpio_irq_request/release_resources() model.
>
> So, we might wait for the solution to settle in 3.15-rc before building
> on top of it.

It's not such a big deal IMO, but sure I'm working to clean this up.

Yours,
Linus Walleij
