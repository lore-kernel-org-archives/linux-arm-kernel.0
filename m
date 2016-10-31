From: eric@anholt.net (Eric Anholt)
Date: Mon, 31 Oct 2016 10:53:15 -0700
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <2009597620.98560.11cdcb7c-b46d-43f0-a853-b742fde3546a.open-xchange@email.1und1.de>
References: <20161027165246.23936-1-eric@anholt.net>
 <2009597620.98560.11cdcb7c-b46d-43f0-a853-b742fde3546a.open-xchange@email.1und1.de>
Message-ID: <877f8os8vo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 27. Oktober 2016 um 18:52 geschrieben:
>> 
>> 
>> From: Linus Walleij <linus.walleij@linaro.org>
>> 
>> The idea is to give useful names to GPIO lines that an implementer
>> will be using from userspace, e.g. for maker type projects.  These are
>> user-visible using tools/gpio/lsgpio.c
>
> sorry for the late feedback, but did you check your patch against the Firmware
> DTS [1]?
>
> As an example the GPIO38 is connected and named as USB_LIMIT_1A2 since Raspberry
> Pi 1 B Plus.
>
> [1] -
> https://github.com/raspberrypi/documentation/blob/master/configuration/images/dt-blob.dts

I did use the dt-blob sometimes for cross-checking, but these are
written against the schematics, not the dt-blob.  If you've got things
you'd like changed, could you send a patch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161031/f5aa89db/attachment.sig>
