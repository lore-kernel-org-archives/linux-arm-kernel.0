From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Dec 2013 02:15:44 +0000 (UTC)
Subject: [PATCH 1/3] ARM: OMAP4+: hwmod data: Don't prevent RESET of USB
 Host module
In-Reply-To: <20131209015838.GA11433@atomide.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
 <1386080748-17005-2-git-send-email-rogerq@ti.com>
 <alpine.DEB.2.02.1312090125170.32309@utopia.booyaka.com>
 <20131209015838.GA11433@atomide.com>
Message-ID: <alpine.DEB.2.02.1312090213210.32309@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 Dec 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131208 17:27]:
> > On Tue, 3 Dec 2013, Roger Quadros wrote:
> > 
> > > Without this, the USB devices are sometimes not detected on OMAP4 Panda
> > > with u-boot v2013.10.
> > > 
> > > Unlike what the comment states, errata i660 does not state that we
> > > can't RESET the USB host module. Instead it states that RESET is the
> > > only way to recover from a deadlock situation.
> > > 
> > > RESET ensures that the module is in a known good state irrespective
> > > of what bootloader does with the module, so it must be done at boot.
> > > 
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > Will you pick this up for the -rc series, or do you want me or Tony to?  
> > Roger writes that this one's pretty important.
> 
> I suggest that you just queue this with your other fixes so we get
> things working.

I'm going to wait until tomorrow anyway to see if Sathya responds to my 
other E-mail, so maybe Beno?t will let us know by then.


- Paul
