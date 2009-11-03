From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Nov 2009 20:54:44 +0100
Subject: patch system doesn't parse From: pseudo header (Was: [PATCH]
	Use REV and REV16 for byte swapping on ARMv6+)
In-Reply-To: <20091026110524.GB22097@n2100.arm.linux.org.uk>
References: <1256374782-5803-1-git-send-email-rabin@rab.in>
	<20091024111357.GD16451@n2100.arm.linux.org.uk>
	<1256554966.5282.15.camel@pc1117.cambridge.arm.com>
	<20091026110524.GB22097@n2100.arm.linux.org.uk>
Message-ID: <20091103195444.GB20260@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Oct 26, 2009 at 11:05:24AM +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 26, 2009 at 11:02:46AM +0000, Catalin Marinas wrote:
> > On Sat, 2009-10-24 at 12:13 +0100, Russell King - ARM Linux wrote:
> > > On Sat, Oct 24, 2009 at 02:29:42PM +0530, Rabin Vincent wrote:
> > > > ARMv6 introduced the REV and REV16 instructions that reverse bytes in
> > > > words and halfwords.  Use them for the arch-specific implementation of
> > > > the byte swapping helpers on ARMv6+.
> > > 
> > > Please submit to the patch system.  Note that you can now use this format,
> > > and just put the "KernelVersion:" header somewhere in before the 'diff'
> > > line.
> > 
> > (OT) Does it also now parse a "From:" line (if the author differs from
> > the sender)?
> 
> No.  Reasons explained previously.
Hmm, it's hard to search for From: in the archives, so the best hit I
found is:

	http://thread.gmane.org/gmane.linux.ports.arm.kernel/32274/focus=32651

Is it that you mean?

I would make use of such a pseudo header, too.  From time to time I
mainline patches created by colleagues.  So in the end it's me who adds
the patch even though I'm not the author.

I don't know how your patch system works but if you point me to its
source I might have a look how to implement it.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
