From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 21:09:29 +0100
Subject: [PATCH V2] media: i2c: Add ADV761X support
In-Reply-To: <5298F3A1.7070503@metafoo.de>
References: <1384520071-16463-1-git-send-email-valentine.barshak@cogentembedded.com>
 <5295E231.9030200@cisco.com> <5295E641.6060603@cogentembedded.com>
 <2150651.hQNra4Rlob@avalon>
 <CACRpkdZQa626hNRFcGvk4t7Z8scTCoEcf7AqO-FsL=BGk6UfeA@mail.gmail.com>
 <52987058.80700@metafoo.de>
 <CACRpkdYuiwH5MzdY3HO7oBSGLqRr5t4HMvGscjsf4QL2G1wiNw@mail.gmail.com>
 <52989B13.8010207@metafoo.de>
 <CACRpkda89fqGd6+ShvFXz-7i56KfG43EggBtjbdKyOCGnJu5Cg@mail.gmail.com>
 <5298F3A1.7070503@metafoo.de>
Message-ID: <CACRpkdbgbb_dcxyaGpdpwiHxd9p1bEc2JB5bzK5dDBHFcHwjzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 9:05 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/29/2013 08:52 PM, Linus Walleij wrote:

>> I guess you may be referring to the problem of instatiating
>> a dynamic IRQ chip in *board code* and then passing the
>> obtained dynamic IRQ numbers as resources to the
>> devices also created in a board file?
>>
>
> Yes.
>
>> That would be like you're asking for a function that would
>> return the base of an irq_chip, that needs to be discussed
>> with the irq maintainers, so not much I can say, but maybe
>> I misunderstood this?
>
> I my opinion the best solution for this problem is to have the same lookup
> mechanism we've had for clocks, regulators, etc and now also GPIOs.

Hm this needs to be discussed with some irq people...

Yours,
Linus Walleij
