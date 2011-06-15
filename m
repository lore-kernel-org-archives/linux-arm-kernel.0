From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Wed, 15 Jun 2011 07:36:34 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110615083437.GA32624@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
	<20110614223404.GA30057@linux-mips.org>
	<4DF8329C.7000904@zytor.com>
	<20110615083437.GA32624@linux-mips.org>
Message-ID: <20110615143634.GA12757@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 04:34:37AM -0400, Ralf Baechle wrote:
> On Tue, Jun 14, 2011 at 09:18:36PM -0700, H. Peter Anvin wrote:
> 
> > On 06/14/2011 03:34 PM, Ralf Baechle wrote:
> > > 
> > > There is no point in offering to build something that couldn't possibly be
> > > used.  It just makes the kernel harder to configure and inflates the test
> > > matrix for no good reason.
> > > 
> > 
> > I see... that's why a bunch of devices that only exist on ARM and MIPS
> > SoCs are offered on x86 platforms?
> 
> Well, if you notice one of those, yell.  Or send patches.  Most of those
> have been fixed.
> 
I think he was being sarcastic, and wanted to say that it should be that way.

Guenter
