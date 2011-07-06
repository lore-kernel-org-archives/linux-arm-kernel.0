From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 20:46:00 +0100
Subject: [PATCH RESEND 2] arm: mach-vt8500: add forgotten irq_data
	conversion
In-Reply-To: <20110706193303.GP8286@n2100.arm.linux.org.uk>
References: <1309979227-24578-1-git-send-email-w.sang@pengutronix.de>
	<20110706193303.GP8286@n2100.arm.linux.org.uk>
Message-ID: <20110706194559.GR8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:33:03PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 09:07:07PM +0200, Wolfram Sang wrote:
> > This fixes a build failure and is acked by the platform maintainer. As
> > there might be no -rc7 and the release might be soon, I'll try adding
> > two more people to CC to increase chances to have that issue sorted out
> > in 3.0
> 
> I'd much rather tglx Acked this as the irq maintainer and Arnd picked
> it up...

I've taken this into my fixes branch as well...
