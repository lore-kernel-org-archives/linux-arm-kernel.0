From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Aug 2015 14:47:31 +0100
Subject: [PATCH 1/3] Docs: dt: add generic MSI bindings
In-Reply-To: <CAL_Jsq+-xKsfBwqjHnSKPxtO1muu-NLEHZTTLpSqw=sBuU1Gjw@mail.gmail.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-2-git-send-email-mark.rutland@arm.com>
 <20150805165120.GB28849@leverpostej>
 <20150824101755.GC7139@leverpostej>
 <CAL_Jsq+-xKsfBwqjHnSKPxtO1muu-NLEHZTTLpSqw=sBuU1Gjw@mail.gmail.com>
Message-ID: <20150824134731.GA31344@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 02:37:59PM +0100, Rob Herring wrote:
> On Mon, Aug 24, 2015 at 5:17 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Aug 05, 2015 at 05:51:20PM +0100, Mark Rutland wrote:
> >> Rob,
> >>
> >> Do you have any objections to this, or are you happy to take this patch?
> >>
> >> There's a user of this binding (the GICv3 ITS) queued for v4.3 already in
> >> the tip tree, so either we either need to be ok with this binding or we
> >> need to rework that before v4.3.
> >
> > Sorry to ping, but are you happy to take this? Marc's replied and
> > provided his ack.
> 
> Sorry. Looks fine to me, so I'll apply.

Cheers!

> What about patch 2 and 3? I can't find patch 3 in my mail.

Those should wait for now.

We don't yet have a user and there's ongoing discussion w.r.t. the PCI
parts that I expect will pick up again as people return from LPC.

Thanks,
Mark.
