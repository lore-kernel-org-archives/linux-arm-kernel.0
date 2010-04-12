From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 12 Apr 2010 08:22:24 +0100
Subject: [PATCH 1/2] ixp4xx: base support for Arcom Vulcan
In-Reply-To: <20100412112045.58dad272@ironhide>
References: <1270931559-9414-1-git-send-email-maz@misterjones.org>
	<20100412112045.58dad272@ironhide>
Message-ID: <20100412082224.08dadc09@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Apr 2010 11:20:45 +0530
Amit Walambe <amit.walambe@eurotech.com> wrote:

Hi Amit,

> On Sat, 10 Apr 2010 21:32:38 +0100
> Marc Zyngier <maz@misterjones.org> wrote:
> > +++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
> > @@ -0,0 +1,246 @@
> > +/*
> > + * arch/arm/mach-ixp4xx/vulcan-setup.c
> > + *
> > + * Arcom/Eurotech Vulcan board-setup
> > + *
> > + * Copyright (C) 2010 Marc Zyngier <maz@misterjones.org>
> > + *
> > + * based on fsg-setup.c:
> > + *	Copyright (C) 2008 Rod Whitby <rod@whitby.id.au>
> Can you please add Eurotech in the 'based-on' list?

Actually, this port was done over the week-end *without* access to
Arcom/Eurotech's source code (the only thing I was able to download
from the Eurotech web site is the board documentation). I'm usually
extra careful when it comes to attributions... 

Some of the settings have been reverse-engineered from the bootloader
(the EXP_CS* timing section), and the rest is only based on the
documentation. That's probably why there is no PC/104 support yet
(still working on it). But honnestly, this is a classical IXP425
implementation, without anything fancy (much less effort than the PXA
boards where source access was actually useful, and proper attribution
was mentioned).

I can always add a "Based on Eurotech's documentation", if you want.

Cheers,

	M.
-- 
I'm the slime oozin' out from your TV set...
