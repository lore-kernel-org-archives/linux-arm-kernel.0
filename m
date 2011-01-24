From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 24 Jan 2011 15:03:49 +0530
Subject: [PATCH v7] OMAP2+: PM: omap device: API's for handling
	mstandby mode
In-Reply-To: <20101214014822.GA3858@manju-desktop>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
	<4CF8AC8B.9040800@ti.com> <20101203092514.GA10048@GLPP-machine>
	<4CF8E03A.4010000@ti.com> <20101214014822.GA3858@manju-desktop>
Message-ID: <20110124093349.GC16582@m-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul/Benoit,

On Tue, Dec 14, 2010 at 07:18:22AM +0530, G, Manjunath Kondaiah wrote:
> Paul/Benoit,
> 
> On Fri, Dec 03, 2010 at 01:19:06PM +0100, Cousson, Benoit wrote:
> > On 12/3/2010 10:47 AM, G, Manjunath Kondaiah wrote:
> > >* Cousson, Benoit<b-cousson@ti.com>  [2010-12-03 09:38:35 +0100]:
> > 
> > [...]
> > 
> > >>>v7: replaced mutex lock with spin lock. Added use count for controlling
> > >>>access to sysconfig registers in case if overlapping request/release API's
> > >>>are used.
> > >>
> > >>I'm not sure it should be done here. I'd rather keep that code in
> > >>the DMA, since this is the only user of that feature.
> > >
> > >Are you referring to spin lock or usage count?
> > 
> > The spinlock is needed, I was referring to the usage count.
> > 
> > That being said, the API proposed by Paul (request/release
> > ) sound like a get/put, so maybe he had that kind of usage in mind.
> > 
> > I'm still not convince it should be done at hwmod API level.
> > 
> > 
> > Paul,
> > Any thoughts on that?
> 
> How do we proceed further?
Gentle reminder!

Can we please align on this so that DMA sysconfig patches can be
upstreamed?

Discussion on this topic can be accessed at:
https://patchwork.kernel.org/patch/372231/
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg39728.html

-Manjunath
