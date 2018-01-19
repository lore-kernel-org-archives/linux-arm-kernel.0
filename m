From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 16:14:23 +0100
Subject: [PATCH] phy: work around 'phys' references to usb-nop-xceiv
 devices
In-Reply-To: <c38e54f7-4dbd-72dc-e1fb-9003435cbe0e@i2se.com>
References: <20180112101223.3661181-1-arnd@arndb.de>
 <CAL_JsqKi30aUiJUdjnen+sty_2horaTVs5LFaFJdxACsvEQpkg@mail.gmail.com>
 <c38e54f7-4dbd-72dc-e1fb-9003435cbe0e@i2se.com>
Message-ID: <CAK8P3a2FEdhVXGHT3VE43LE9Rn-WNp+woasb9EwVAr8twVw2Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 11:35 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 12.01.2018 um 20:54 schrieb Rob Herring:
>> On Fri, Jan 12, 2018 at 4:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>>> ---
>>> Hans tested the earlier version of this patch, I'd like one more
>>> confirmation from Hans or Stefan (or anyone else) that this version
>>> addresses the regression as well before this gets merged.
>>>
>>> Greg, can you pick this up into usb-linus for v4.15 once the fix
>>> has been confirmed, or should I merge it through arm-soc?
>>> ---
>>>  drivers/phy/phy-core.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>> Thanks for fixing this.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Rob
>
> ping ...

I ended up putting it into arm-soc/fixes. I assume that Greg missed it
while he was
busy getting the latest stable kernels out. I'll send a pull request
to Linus and
explain it there today.

     Arnd
