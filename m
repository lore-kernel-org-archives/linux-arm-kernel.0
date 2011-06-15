From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2011 08:39:35 +0100
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <4DF8359F.10809@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
	<4DF8359F.10809@zytor.com>
Message-ID: <20110615073935.GA28989@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
> On 06/14/2011 03:08 PM, Luck, Tony wrote:
> > I took a look at the back of all my ia64 systems - none of them
> > have a parallel port.  It seems unlikely that new systems will
> > start adding parallel ports :-)
> > 
> > So even if I had a printer (or other device) that used a parallel
> > port, I have no way to test it.
> 
> If it has PCI slots, it can have a parallel port.

Is that a clue about where a select statement should be?
