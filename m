From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Feb 2012 15:56:11 -0800
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <20120213222220.GI1426@atomide.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <20120213222220.GI1426@atomide.com>
Message-ID: <20120213235611.GK1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120213 13:54]:
> * Rob Herring <robherring2@gmail.com> [120213 13:12]:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > This series cleans-up mach/io.h and removes it for most platforms that have
> > the same definitions of __io() and __mem_pci(). This mainly leaves platforms
> > with PCI that need an io.h. Most of those can be converted once we have a
> > fixed IO space mapping. OMAP io.h also remains as moving all the extra io.h
> > stuff leaves it quite broken, so I'm leaving it to the OMAP folks to convert.
> 
> I'll do some patches to use iomap.h on omaps. Are you planning to queue
> these for v3.4 merge window?
> 
> If these are for v3.5 merge window, then I'll do a cleanup series that
> just leaves a minimal io.h for omaps that's easy to convert. If you're
> still planning these for v3.4 merge window, I'll rebase on your series.

Posted the series to mov most of omap io.h into omap-iomap.h. It's intended
as a clean-up series before your patches so omap io.h can then be removed.

The series is Subject: [PATCH 0/3] Move most of omap io.h into omap-iomap.h.

Regards,

Tony
