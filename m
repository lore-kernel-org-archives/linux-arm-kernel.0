From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2011 15:02:41 +0200
Subject: [PATCH v2 0/6] ARM: make mach/hardware.h optional
In-Reply-To: <4E1B176E.3030503@gmail.com>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<201107021124.46953.arnd@arndb.de> <4E1B176E.3030503@gmail.com>
Message-ID: <201107121502.41570.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 July 2011, Rob Herring wrote:
> > 
> > This is very good work, I really like it. I've mentioned one idea for
> > an improvement in patch 5, which you can still integrate, but otherwise
> > 
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > for the whole series.
> > 
> 
> I have an updated version ready to send out. Will you take this in your
> tree including the 1st patch for pci flags functions? Also, what about
> the powerpc conversion to generic pci flags?

I can take it all in the arm-soc tree, yes. However for anything outside
of arch/arm/{mach,plat}-*, please get an Ack from the respective maintainer
(Russell, Michal, BenH, ...).

	Arnd
