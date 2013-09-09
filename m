From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Sep 2013 16:09:43 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
In-Reply-To: <CACRpkdYwA0ADogtB8RfkZt2bmdbr-PmjvV1=xBKam15DXi9F8A@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034608.12546.79411.sendpatchset@w520>
 <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
 <20130909001524.GD21921@verge.net.au>
 <CACRpkdYwA0ADogtB8RfkZt2bmdbr-PmjvV1=xBKam15DXi9F8A@mail.gmail.com>
Message-ID: <20130909070941.GA27194@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 08:54:59AM +0200, Linus Walleij wrote:
> On Mon, Sep 9, 2013 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Sep 06, 2013 at 06:27:22PM +0200, Linus Walleij wrote:
> 
> >> Again this looks like it is piling up more legacy clk
> >> code instead of moving to the new frameworks.
> >>
> >> Please include Mike Turquette on future postings of the
> >> clk code, he's definately our best clock code reviewer.
> >
> > Perhaps I was a bit hasty, but I have already queued up these changes.
> > And moreover I believe they are useful in their current form for
> > back-porting to LTSI-3.4, which I have also already done.
> 
> That sounds like you're a bit too trigger-happy ;-)

Perhaps.

> > So on those two counts my preference would be for any enhancements
> > to be done as incremental patches on top of this series.
> 
> Hm hm. I am worried that it is taken as an OK to proceed
> extending old cruft for new SoCs rather than moving to new
> frameworks. I would agree if such migration patches were
> floating the lists but I am not aware of any patches starting
> to create drivers/clk/sh*, are you?

I am not aware of such patches.

I will defer this to Magnus who is both the author of this series
and I believe the person who knows the most about the plans for
drivers/clk/sh*.
