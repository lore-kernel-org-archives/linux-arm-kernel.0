From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jun 2011 16:40:58 +0100
Subject: [linux-pm] [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
Message-ID: <20110609154058.GA24424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
> Btw, when testing this I found that generic cpu_suspend seems to be just  
> fine for OMAP3; the OMAP platforms though do not at this time use the  
> generic cpu_suspend/resume for sleep, is it planned to change that ?

That's because OMAP was doing changes to their sleep code while I was
consolidating the sleep code, and although I asked several times that
the OMAP folk should participate in this effort, but evidentally I was
unsuccessful in achieving anything in that direction.

And of course since then it's been forgotten about, and I've given up
on that particular aspect.  I've also come to the conclusion that OMAP
is sufficiently weird (requiring soo much to execute from SRAM) that
its hopeless to persue.
