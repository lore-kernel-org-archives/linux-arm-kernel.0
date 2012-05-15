From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 18:30:14 +0200
Subject: [PATCH v1 0/7] preliminary work for adding imx6q_sabrelite usb
 support
In-Reply-To: <20120515152105.GE23916@kroah.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <201205151628.19020.marex@denx.de> <20120515152105.GE23916@kroah.com>
Message-ID: <201205151830.15009.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg KH,

> On Tue, May 15, 2012 at 04:28:18PM +0200, Marek Vasut wrote:
> > Dear Richard Zhao,
> > 
> > > The work is based on usb-next which includes ci13xxx rework by
> > > Alexander Shishkin.
> > > 
> > > Status:
> > >   - this version only tested host
> > >   - usbotg controler works at host role
> > > 
> > > Todo:
> > >   - usbh1 has strange system error when enumerate devices for on-board
> > >   hub. - high speed usb connecton detect failed for the second time.
> > >   It needs
> > > 
> > > hub code hack.
> > > 
> > > Thanks Peter Chen for greate help.
> > 
> > Hm, I think we should somehow coordinate, because I think we're working
> > on the same thing and we're duplicating work.
> 
> Ok, can the two of you work together on this so I don't get conflicting
> patches, and so you both can verify it works properly for your systems?

Yes, I'd prefer to.

Richard, are these 7 patches the only stuff that I have to apply on top of 
linux-usb/usb-next to get this working?

> thanks,
> 
> greg k-h

Best regards,
Marek Vasut
