From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 31 Oct 2016 19:00:33 +0100 (CET)
Subject: [PATCH v3] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <877f8os8vo.fsf@eliezer.anholt.net>
References: <20161027165246.23936-1-eric@anholt.net>
 <2009597620.98560.11cdcb7c-b46d-43f0-a853-b742fde3546a.open-xchange@email.1und1.de>
 <877f8os8vo.fsf@eliezer.anholt.net>
Message-ID: <529927781.27121.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 31. Oktober 2016 um 18:53 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Eric,
> >
> >> Eric Anholt <eric@anholt.net> hat am 27. Oktober 2016 um 18:52 geschrieben:
> >> 
> >> 
> >> From: Linus Walleij <linus.walleij@linaro.org>
> >> 
> >> The idea is to give useful names to GPIO lines that an implementer
> >> will be using from userspace, e.g. for maker type projects.  These are
> >> user-visible using tools/gpio/lsgpio.c
> >
> > sorry for the late feedback, but did you check your patch against the
> > Firmware
> > DTS [1]?
> >
> > As an example the GPIO38 is connected and named as USB_LIMIT_1A2 since
> > Raspberry
> > Pi 1 B Plus.
> >
> > [1] -
> > https://github.com/raspberrypi/documentation/blob/master/configuration/images/dt-blob.dts
> 
> I did use the dt-blob sometimes for cross-checking, but these are
> written against the schematics, not the dt-blob.  If you've got things
> you'd like changed, could you send a patch?

A patch against your v3 or my own v4 based on your patch?
