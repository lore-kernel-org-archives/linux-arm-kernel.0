From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 10:16:55 -0800
Subject: [PATCH-V3 4/4] arm:omap:am33xx: Add low level debugging support
In-Reply-To: <79CD15C6BA57404B839C016229A409A8023D3A@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1316529142-27564-5-git-send-email-hvaibhav@ti.com>
 <20111006230904.GA6324@atomide.com>
 <79CD15C6BA57404B839C016229A409A8023D3A@DBDE01.ent.ti.com>
Message-ID: <20111107181655.GV31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [111107 06:42]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Friday, October 07, 2011 4:39 AM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap at vger.kernel.org; Hilman, Kevin; paul at pwsan.com; linux-arm-
> > kernel at lists.infradead.org; Mohammed, Afzal
> > Subject: Re: [PATCH-V3 4/4] arm:omap:am33xx: Add low level debugging
> > support
> > 
> > * hvaibhav at ti.com <hvaibhav@ti.com> [110920 06:59]:
> > > From: Afzal Mohammed <afzal@ti.com>
> > >
> > > Add support for low level debugging on AM335X EVM (AM33XX family).
> > > Currently only support for UART1 console, which is used on AM335X EVM
> > > is added.
> > 
> > Let's wait a bit on this one as there are other DEBUG_LL patches
> > pending from Nico.
> > 
> Tony,
> 
> Is there any branch or repo against which I can rebase my patches?

I recommend the current fixes branch.

Tony
