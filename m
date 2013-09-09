From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Sep 2013 09:15:24 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a7791 SCIF support
In-Reply-To: <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034608.12546.79411.sendpatchset@w520>
 <CACRpkdY=j_XRPd9-CV-wj9ajSDZMA1H=k8uK1T2040rmfY=R_A@mail.gmail.com>
Message-ID: <20130909001524.GD21921@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 06:27:22PM +0200, Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 5:46 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > From: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> >
> > Add SCIF serial port support to the r8a7791 SoC by
> > adding platform devices for SCIFA0 -> SCIFA5 as well
> > as SCIFB0 -> SCIFB2 and SCIF0 -> SCIF5 together with
> > clock bindings. DT device description is excluded at
> > this point since such bindings are still under
> > development.
> 
> A good way to get started with clock bindings may be to
> move the clocks to drivers/clk because in the neighboring
> drivers over there are many good examples of how to do
> this.
> 
> Again this looks like it is piling up more legacy clk
> code instead of moving to the new frameworks.
> 
> Please include Mike Turquette on future postings of the
> clk code, he's definately our best clock code reviewer.

Perhaps I was a bit hasty, but I have already queued up these changes.
And moreover I believe they are useful in their current form for
back-porting to LTSI-3.4, which I have also already done.

So on those two counts my preference would be for any enhancements
to be done as incremental patches on top of this series.
