From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 3 Feb 2012 16:05:49 -0800
Subject: [PATCH V2 1/4] i2c: tegra: Add __devinit/exit to probe/remove
In-Reply-To: <CAOesGMjx0nA5Y_Cv8ECBcZP45EyR5BPUNXEapCN3JjdWTjpo8A@mail.gmail.com>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
 <20111220015634.GA27789@quad.lixom.net>
 <CAM=Q2cs8K4vraWPNqervcmxEqUGiAbng+44+L9OhD3ijPw9tAA@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92E21@HQMAIL01.nvidia.com>
 <20120106162615.GA8441@trinity.fluff.org>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E15@HQMAIL01.nvidia.com>
 <CAOesGMjx0nA5Y_Cv8ECBcZP45EyR5BPUNXEapCN3JjdWTjpo8A@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E5D30DD@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Friday, January 06, 2012 10:45 AM:
> On Fri, Jan 6, 2012 at 8:47 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Ben Dooks wrote at Friday, January 06, 2012 9:26 AM:
> >> On Tue, Dec 20, 2011 at 01:47:29PM -0800, Stephen Warren wrote:
> >> > Shubhrajyoti Datta wrote at Monday, December 19, 2011 11:15 PM:
> >> > ...
> >> > > Hi Stephen ,
> >> > > could you check this one also
> >> > > thanks.
> >> > >
> >> > > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> >> > > Date: Tue, 20 Dec 2011 11:40:51 +0530
> >> > > Subject: [PATCH] I2C : tegra : devexit in remove
> >> > >
> >> > > Adding I2C __devexxit in remove
> >> > >
> >> > > Cc: Stephen Warren <swarren@nvidia.com>
> >> > > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> >> >
> >> > Acked-by: Stephen Warren <swarren@nvidia.com>
> >> >
> >> > Ben or Olof,
> >> >
> >> > > - ? ? ? .remove ?= tegra_i2c_remove,
> >> > > + ? ? ? .remove ?=__devexit_p(tegra_i2c_remove),
> >> >
> >> > When you apply this, can you fix it up to add a space after the = in
> >> > the modified line? If you want, I can post an updated version to do that.
> >>
> >> Let me know if you want anything applying or a pull-request processed.
> >>
> >> I think once fixed the patches would be fine and I ack them:
> >>
> >> Acked-by: Ben Dooks <ben-linux@fluff.org>
> >
> > Olof, since you took the original through the Tegra tree, I think it
> > makes sense for us to take this fix through there too, and for 3.3?
> > The patch above is http://patchwork.ozlabs.org/patch/132349/
> 
> Yep, will do.

I haven't seen this show up anywhere yet.

-- 
nvpublic
