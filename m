From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2012 09:31:40 -0700
Subject: [PATCH v8 0/3] GPMC driver conversion
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E1D9B@DBDE01.ent.ti.com>
References: <cover.1346846464.git.afzal@ti.com>
 <20120907221034.GP1303@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E1D9B@DBDE01.ent.ti.com>
Message-ID: <20120911163140.GC23092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120911 03:54]:
> Hi Tony,
> 
> On Sat, Sep 08, 2012 at 03:40:34, Tony Lindgren wrote:
> 
> > Great, this all looks good to me. I suggest that on top of this
> > we add minimal devicetree binding that does not even attempt to
> > deal with the timings yet.
> > 
> > Then once the minimal devicetree binding is in place, we can
> > call the current GPMC timing functions using the compatible flags
> > and auxdata in the gpmc.c driver.
> > 
> > That way we get all the legacy boards booting with GPMC support
> > for smsc911x etc, and can even remove some less used board-*.c
> > files.
> 
> Thanks. I agree with your suggestion and would be proceeding so
> as to achieve minimal devicetree support.
> 
> And a newer version of this series has been posted.

OK great!
 
> > Then we just add the generic GPMC timings when we're happy with
> > those.
> 
> Meanwhile can you send me the gpmc debug logs for n800 where tusb
> patch on generic timing was causing the hang along with logs
> without the culprit tusb patch so that we could arrive at generic
> gpmc timings.

Yes sorry been meaning to do that but keep getting distracted
continuously somehow..

Tony
