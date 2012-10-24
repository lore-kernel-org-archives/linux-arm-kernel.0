From: nbowler@elliptictech.com (Nick Bowler)
Date: Wed, 24 Oct 2012 16:19:28 -0400
Subject: [PATCH v2 2/4] zynq: move static peripheral mappings
In-Reply-To: <20121023234219.GM20593@beefymiracle.amer.corp.natinst.com>
References: <20121022211219.GC31538@beefymiracle.amer.corp.natinst.com>
 <201210231450.11540.arnd@arndb.de>
 <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
 <20121023202703.GA16912@elliptictech.com>
 <20121023234219.GM20593@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121024201928.GA31069@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-23 18:42 -0500, Josh Cartwright wrote:
> On Tue, Oct 23, 2012 at 04:27:03PM -0400, Nick Bowler wrote:
> > Just FYI, I sent a patch to fix the same bug a while back
> >
> >   https://patchwork.kernel.org/patch/1156361/
> >
> > together with other patches to fix early printk on the ZC702 serial
> > console.  Admittedly, I dropped the ball on these as other issues
> > came up so I was away from the Zynq for a while.
> >
> > However, I'm now getting back on the Zynq and have a bunch of patches to
> > make it all work on the ZC702 board.  I've respun the ZC702 early boot
> > fixes against newer git but they're obviously going to conflict with
> > this series.  Should I resend them anyway?
> 
> If you have other fixes for the zc702, that'd be great.  Most of my
> testing has been in a qemu model; I haven't had a chance to try getting
> the zc702 booting yet.
> 
> The first stumbling block is that it looks like the secondary uart is
> the primary uart on the zc702.

Yes, that is indeed the case, and was what I tried to address with my
earlier patches.

> > I also have a DT binding for the TTC driver, I can send that.
> 
> That'd be great!

OK, I will respin and test this stuff on top of your v4 series and send
them out.

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
