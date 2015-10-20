From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 20 Oct 2015 10:41:49 +0200
Subject: [RESEND PATCH v2 2/2] ARM: imx6: change default burst size for USB
In-Reply-To: <20151020070718.GC7203@shlinux2>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
 <1443579437-845-2-git-send-email-peter.chen@freescale.com>
 <1443603159.3185.5.camel@pengutronix.de> <20150930133712.GG16362@tiger>
 <20151020070718.GC7203@shlinux2>
Message-ID: <1445330509.3716.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Dienstag, den 20.10.2015, 15:07 +0800 schrieb Peter Chen:
> On Wed, Sep 30, 2015 at 09:37:12PM +0800, Shawn Guo wrote:
> > On Wed, Sep 30, 2015 at 10:52:39AM +0200, Lucas Stach wrote:
> > > Am Mittwoch, den 30.09.2015, 10:17 +0800 schrieb Peter Chen:
> > > > It can improve the USB performance when choosing larger
> > > > burst size at some systems (bus size is larger), there is
> > > > no side effect if this burst size is larger than bus size.
> > > > 
> > > Just for the record, as it seems too late to stop the train now:
> > > 
> > > I am _NOT_ happy that the extended binding has been accepted into the
> > > USB tree despite outstanding review comments from me not being addressed
> > > or even answered.
> > 
> > Okay.  I'm not aware of this.  I'm dropping the patches until everyone
> > agrees with it.
> > 
> 
> Hi Shawn & Lucas, I sent the improvement patch for dt description following 
> Lucas's comment one week ago at below:
> 
> https://www.spinics.net/lists/linux-usb/msg131150.html
> 
> If no more comments, queue my dts patches please.
> 
While the binding hasn't received a good review in time it is already in
a released kernel and I'm not going to argue to change it now after the
fact (violating the DT stability rules) just to satisfy my rather minor
comments. I want to make clear that I was not happy by how this stuff
has been handled with the USB tree and it is my hope that this can be
improved for future binding changes.

But please don't hold those DTS patches any longer. The binding is in,
there is no point in not applying the corresponding patches.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
