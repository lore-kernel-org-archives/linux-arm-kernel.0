From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 27 Dec 2012 14:52:22 -0500
Subject: [PATCH] ARM: Kirkwood: Bundle the common pinctrl of 88f6281
 and 88f6282
In-Reply-To: <20121227170524.GX21694@titan.lakedaemon.net>
References: <1356230149-15437-1-git-send-email-iwamatsu@nigauri.org>
 <20121227170524.GX21694@titan.lakedaemon.net>
Message-ID: <20121227195222.GZ21694@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 12:05:24PM -0500, Jason Cooper wrote:
> On Sun, Dec 23, 2012 at 11:35:49AM +0900, Nobuhiro Iwamatsu wrote:
> > 88f6281 and 88f6282 has common pinctrl.
> > This buldles the common pincrtl of these to kirkwood-628x-base.dtsi.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  arch/arm/boot/dts/kirkwood-6281.dtsi      |   38 ++------------------------
> >  arch/arm/boot/dts/kirkwood-6282.dtsi      |   35 ++----------------------
> >  arch/arm/boot/dts/kirkwood-628x-base.dtsi |   41 +++++++++++++++++++++++++++++
> 
> Is there a reason we can't move the contents of the proposed
> kirkwood-628x-base.dtsi into kirkwood.dtsi ?

Also, once we figure this out, could you please base your other patch
series on top of this?  Putting the cleanups before the changes helps us
avoid merge conflicts as we pull everything together.

thx,

Jason.
