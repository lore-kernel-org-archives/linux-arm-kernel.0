From: eric@anholt.net (Eric Anholt)
Date: Thu, 20 Oct 2016 10:04:14 -0700
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
References: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
 <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
Message-ID: <87eg3bvto1.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Oct 18, 2016 at 10:44 PM, Gottfried Haider
> <gottfried.haider@gmail.com wrote:
>
>> Regarding the proposed format using the header pin numbers: From what I've
>> seen in terms of existing educational materials, it seems the overwhelming
>> majority ends up using GPIO numbers instead of physical pin header
>> numbering. (e.g. [1] [2])
>
> What does that number mean? If you are referring to the global
> GPIO numberspace it is obsolete and just reflecting the fact that
> people up until now was referring to Linux-internal GPIO numbers.

The number within the SOC's GPIOs.  Until the 8-line expander that's
been hung off the SOC GPIOs in the Pi3, they were the only GPIOs in the
system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/3bd2a4ea/attachment.sig>
