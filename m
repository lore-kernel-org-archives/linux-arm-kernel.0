From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 10 Jan 2016 14:38:00 +0100 (CET)
Subject: [PATCH] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
In-Reply-To: <yw1xoacty3uz.fsf@unicorn.mansr.com>
References: <1452429613-28783-1-git-send-email-mans@mansr.com>
 <1473600647.505612.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
 <yw1xoacty3uz.fsf@unicorn.mansr.com>
Message-ID: <89586980.506110.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> M?ns Rullg?rd <mans@mansr.com> hat am 10. Januar 2016 um 14:13 geschrieben:
>
>
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
> > Hi Mans,
> >
> >> Mans Rullgard <mans@mansr.com> hat am 10. Januar 2016 um 13:40 geschrieben:
> >>
> >>
> >> Add pinmux setting for USB1 overcurrent on pwm2 pad.
> >
> > could you please change your patch to describe why you need to add
> > this pinmux?
>
> I'm working on a board that is wired that way. I can of course put this
> in the board-specific dts if that's preferable.

So the board isn't submitted to mainline?

IMHO the change is okay, but the description doesn't explain why is it needed.

So a suitable description would be that it's needed for board xy.

>
> --
> M?ns Rullg?rd
