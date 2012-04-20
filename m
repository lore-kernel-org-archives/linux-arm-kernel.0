From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 20 Apr 2012 15:00:21 +0200
Subject: [RFC PATCH 00/10 V3] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204201444.49184.marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <20120420094805.GS20478@pengutronix.de>
 <CAL411-onyB8SJEBoJ2XK=wyHKR0C7SyJtCsoJCDZGatP8HmYZg@mail.gmail.com>
 <201204201444.49184.marex@denx.de>
Message-ID: <20120420130021.GX31760@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 02:44:48PM +0200, Marek Vasut wrote:
> > From the function and quality level, fsl_udc_core.c is absolutely
> > the best one for all i.mx SoCs, as both internal and upstream fsl
> > code use it.
>
> Internally though, it looks like crap. Also, ci13xxx and fsl_usb_core
> is duplicated stuff, correct?

As far as I know, this is a "Synopsys USB 2.0 High Speed Altantic
Controller". There are different drivers in mainline for this core:

- ci13xxx_udc
- fsl_usb_core
- langwell_udc

I think there even was a fourth, but I can't remember which one.

All with a different level of abstraction and features.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
