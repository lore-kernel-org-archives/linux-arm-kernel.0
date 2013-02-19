From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 21:30:33 +0000
Subject: [GIT PULL] reworked omap usb pdata changes for v3.9 merge window
In-Reply-To: <20130215003543.GF11806@atomide.com>
References: <20130215003543.GF11806@atomide.com>
Message-ID: <201302192130.33509.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Roger Quadros reworked the OMAP USB patches that were causing
> a conflict in Linux next and we requested to be dropped from
> Linux next and reworked to remove the dependencies between
> core SoC code and the driver code.
> 
> Below is a pull request for the mach-omap2 specific parts, the
> rest is driver specific and queued by Samuel in the MFD tree
> and Greg for the USB changes.
> 
> I've left it unresolved so you can merge it into one of your
> branches as a dependency so we can avoid the merge conflict
> in Linux next. A link to the merge resolution done by Stephen
> is in the pull request. Let me know if you want me to resolve
> it instead. 

I've pulled them into next/soc now. I was wondering whether to
put them into the late/omap branch instead, but this seemed
like the easiest way to resolve the conflict, and the patches
are simple enough.

	Arnd
