From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Aug 2010 12:25:40 +0100
Subject: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
In-Reply-To: <20100809103704.GB5826@bnru01.bnr.st.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
	<AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
	<20100729142011.GG18923@n2100.arm.linux.org.uk>
	<20100805061453.GA7524@bnru02.bnr.st.com>
	<20100805092531.GA23473@n2100.arm.linux.org.uk>
	<20100809103704.GB5826@bnru01.bnr.st.com>
Message-ID: <20100809112540.GC10793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 04:07:05PM +0530, Rabin VINCENT wrote:
> On Thu, Aug 05, 2010 at 11:25:31 +0200, Russell King - ARM Linux wrote:
> > On Thu, Aug 05, 2010 at 11:44:54AM +0530, Rabin VINCENT wrote:
> > > so are you OK with the cd_noinvert addition (for the GPIO case)?
> > > Or a cd_invert and a patch to existing platforms?
> > 
> > I'd much prefer positive logic.  Double negatives (eg, not noinverted)
> > are always bad news.
> 
> Here's the new patch.  I'll rebase the rest of the unapplied patches in
> the series on top of this.

This looks much better, thanks.
