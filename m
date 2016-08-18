From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 18 Aug 2016 08:21:56 +0100
Subject: [PATCH v2 1/2] ARM: dts: Remove use of skeleton.dtsi from
 bcm283x.dtsi
In-Reply-To: <1470739709.4745.23.camel@hellion.org.uk>
References: <1470233565-30154-1-git-send-email-ijc@hellion.org.uk>
 <20160803144858.GA29054@leverpostej>
 <1470739709.4745.23.camel@hellion.org.uk>
Message-ID: <1471504916.6295.32.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-09 at 11:48 +0100, Ian Campbell wrote:
> On Wed, 2016-08-03 at 15:48 +0100, Mark Rutland wrote:
> >?
> > > [...]Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> >?
> > I also don't have the relevant hardware to test with, but this
> looks
> > generally like the right thing. So FWIW:
> >?
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks (and Stefan too).
> 
> I think these things generally go via the arm-soc tree? Arnd & Olaf,
> would it be possible to get this fix in for rc2 please (or in any event
> for 4.8). Although it's an external tree I believe build breakage in
> the split-out DT git repo is worth addressing.

This change doesn't appear to be in either v4.8-rc2, Linus' tree nor in
the arm-soc tree that I can see. So, ping?

Or am I barking up the wrong tree pointing this patch towards arm-soc
(via arm at k.o)?

Ian
