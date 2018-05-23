From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 May 2018 11:37:14 -0700
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <243730d3-e7f3-584d-b5dd-491c2700cf11@ti.com>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
 <243730d3-e7f3-584d-b5dd-491c2700cf11@ti.com>
Message-ID: <20180523183714.GR98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [180523 05:58]:
> On 22/05/18 23:01, Rob Herring wrote:
> > On Mon, May 21, 2018 at 09:57:54AM +0300, Tero Kristo wrote:
> > > Ok trying to resurrect this thread a bit. Is there any kind of consensus how
> > > things like this should be handled? Should we add the DT overlay files to
> > > kernel tree or not?
> > 
> > IMO, yes.

I too agree the overlay files should be in the kernel rather than
people having to try to figure out where to find them.

No idea how we'll verify they'll build though :) Maybe we
just need randconfig support for DT overlay files too?

Regards,

Tony
