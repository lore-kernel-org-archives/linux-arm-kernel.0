From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 10 Jan 2016 20:01:58 +0100
Subject: [PATCH] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
In-Reply-To: <89586980.506110.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
References: <1452429613-28783-1-git-send-email-mans@mansr.com>
 <1473600647.505612.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
 <yw1xoacty3uz.fsf@unicorn.mansr.com>
 <89586980.506110.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
Message-ID: <20160110190158.GK24441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jan 10, 2016 at 02:38:00PM +0100, Stefan Wahren wrote:
> > M?ns Rullg?rd <mans@mansr.com> hat am 10. Januar 2016 um 14:13 geschrieben:
> > Stefan Wahren <stefan.wahren@i2se.com> writes:
> >
> > > Hi Mans,
> > >
> > >> Mans Rullgard <mans@mansr.com> hat am 10. Januar 2016 um 13:40 geschrieben:
> > >>
> > >>
> > >> Add pinmux setting for USB1 overcurrent on pwm2 pad.
> > >
> > > could you please change your patch to describe why you need to add
> > > this pinmux?
> >
> > I'm working on a board that is wired that way. I can of course put this
> > in the board-specific dts if that's preferable.
> 
> So the board isn't submitted to mainline?
> 
> IMHO the change is okay, but the description doesn't explain why is it needed.
> 
> So a suitable description would be that it's needed for board xy.

The problem with pinmuxing on i.MX23/28 is that the order of pinmux
groups is to a certain degree important. So not everything is possible
in the machine specific dts. (I didn't have an eye on this issue, maybe
it's fixed in the meantime?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
