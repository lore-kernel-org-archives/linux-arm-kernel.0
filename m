From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 08:39:35 +0100
Subject: [PATCH v3 11/21] ARM: pxa: support ICP DAS LP-8x4x FPGA irq
In-Reply-To: <1389207661.10754.42.camel@host5.omatika.ru>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-12-git-send-email-ynvich@gmail.com>
 <CACRpkdaY7xpoeeUqBBqUS2swe6Y5gKt67VYNvNRrsbFhyU=ATw@mail.gmail.com>
 <1389207661.10754.42.camel@host5.omatika.ru>
Message-ID: <CACRpkda_6P3s3LBwV5ve+=_JhxehephvpPT=pKPk3NzEKQLa9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 8:01 PM, Sergei Ianovich <ynvich@gmail.com> wrote:
> On Thu, 2014-01-02 at 13:32 +0100, Linus Walleij wrote:
>> On Tue, Dec 17, 2013 at 8:37 PM, Sergei Ianovich <ynvich@gmail.com> wrote:
>> Usually combined GPIO+IRQ controllers are put into drivers/gpio but
>> this is a bit special as it seems to handle also non-GPIO-related IRQs
>> so let's get some input on this.
>
> This one is a plain IRQ controller. It has simple input lines, not GPIO
> pins. The chip reports its status to upper level interrupt controller.
> The upper level controller is PXA GPIO in this case.

Hm I don't know why I was deluded into thinking this had something to
do with GPIO. I must have been soft in the head. Sorry about all those
comments ...

I'll re-read the irqchip driver v3.1.

Yours,
Linus Walleij
