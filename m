From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 20 Oct 2015 15:07:20 +0800
Subject: [RESEND PATCH v2 2/2] ARM: imx6: change default burst size for USB
In-Reply-To: <20150930133712.GG16362@tiger>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
 <1443579437-845-2-git-send-email-peter.chen@freescale.com>
 <1443603159.3185.5.camel@pengutronix.de>
 <20150930133712.GG16362@tiger>
Message-ID: <20151020070718.GC7203@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 09:37:12PM +0800, Shawn Guo wrote:
> On Wed, Sep 30, 2015 at 10:52:39AM +0200, Lucas Stach wrote:
> > Am Mittwoch, den 30.09.2015, 10:17 +0800 schrieb Peter Chen:
> > > It can improve the USB performance when choosing larger
> > > burst size at some systems (bus size is larger), there is
> > > no side effect if this burst size is larger than bus size.
> > > 
> > Just for the record, as it seems too late to stop the train now:
> > 
> > I am _NOT_ happy that the extended binding has been accepted into the
> > USB tree despite outstanding review comments from me not being addressed
> > or even answered.
> 
> Okay.  I'm not aware of this.  I'm dropping the patches until everyone
> agrees with it.
> 

Hi Shawn & Lucas, I sent the improvement patch for dt description following 
Lucas's comment one week ago at below:

https://www.spinics.net/lists/linux-usb/msg131150.html

If no more comments, queue my dts patches please.

-- 

Best Regards,
Peter Chen
