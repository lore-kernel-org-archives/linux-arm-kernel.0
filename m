From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 17 Aug 2011 01:20:21 +0100 (BST)
Subject: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
In-Reply-To: <201108161713.34778.marek.vasut@gmail.com>
Message-ID: <1313540421.59810.YahooMailClassic@web29020.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > We could if the NavPoint supported MEP Query $22
> (Touchpad Coordinate Range
> > Query). Unfortunately it doesn't (I tried), presumably
> because the
> > NavPoint uses an older version of MEP (Synaptics
> Modular Embedded
> > Protocol).
> 
> Then you can adjust it via module parameters and have these
> as default values. 
> or sysfs ... maybe sysfs would be better
> > 
> > > Or use sysfs
> > > attributes / module params ?
> > 
> > Or platform data? That's much simpler. Without knowing
> how this driver will
> > be used by other platforms (if at all) I'm wary about
> over-engineering it.
> 
> True ... then likely module params or sysfs to keep it
> simple. Pdata seems 
> stupid.

OK, module parameters are somewhat simpler so I'll go with those.

> > Original authors? I don't understand; would you please
> elaborate.
> 
> I dunno, well you took it from linux-hh tree, right? So if
> there was any 
> original author, give him a credit ... if that's you, just
> ignore this. I didn't 
> expect there to be still someone from -hh times around and
> active :-)

Actually it doesn't come from the hh kernel. I did reference the hh driver for SSP setup such as frame format and data size, since I have no NavPoint documentation, but this driver is new and very much simpler.

Regards,
Paul
