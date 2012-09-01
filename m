From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 1 Sep 2012 23:00:57 +0200
Subject: MX28 & finding out boot mode
In-Reply-To: <20120830095555.GE27306@pengutronix.de>
References: <20120830082518.GA27306@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C630EF@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120830095555.GE27306@pengutronix.de>
Message-ID: <201209012300.57841.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Thu, Aug 30, 2012 at 09:40:05AM +0000, Chen Peter-B29397 wrote:
> > > Some customers want this to handle the recovery case differently than
> > > the standard case.
> > 
> > If you can't find method at datasheet (like reading some registers), a
> > workaround
> 
> I hoped there was one bit in the persistent registers where the ROM
> code stores such stuff. Sadly, those are usually not documented, so I
> asked.
> 
> > is according to usb register, usually, usbcmd.rs (pull-up DP) stands for
> > usb is using or not.
> 
> I think this is too much of a workaround for me :)

I cycled the board a few times and checked the ICOLL setup, but I gave up since 
I don't care enough.

btw. did you cc me on gmail intentionally ? ;-)

> Thanks anyway!

Best regards,
Marek Vasut
