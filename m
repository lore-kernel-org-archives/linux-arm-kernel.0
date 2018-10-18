From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Oct 2018 15:01:05 +0200
Subject: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
In-Reply-To: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
 <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Message-ID: <20181018130105.2guhavajp754qbnk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 09:05:58AM -0500, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 3:02 AM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Fri, Oct 05, 2018 at 11:58:41AM -0500, Rob Herring wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-renesas-soc at vger.kernel.org
> > > Cc: devicetree at vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This seems fine to me other than that it does not seem
> > to apply cleanly to next.
> >
> > shmobile.txt sees a couple of updates per release cycle so from my point of
> > view it would ideal if this change could hit -rc1 to allow patches for
> > v4.21 to be accepted smoothly (already one from Sergei will need rebasing).
> 
> When we get to the point of merging (which isn't going to be 4.20),
> you and other maintainers can probably take all these patches. Other
> than the few restructuring patches, the only dependency is the build
> support which isn't a dependency to apply it, but build it. I plan to
> build any patches as part of reviewing at least early on. OTOH, the
> build support is small enough and self contained that maybe it can
> just be applied for 4.20.

Thanks, understood.

My preference would be to, as you suggest, take changes like
this through the renesas tree.
