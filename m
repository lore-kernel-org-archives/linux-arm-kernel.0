From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 22 Jul 2011 20:31:46 +0200
Subject: [PATCH 0/3] SP805 updates for Versatile Express
In-Reply-To: <20110719131508.GA30207@elliptictech.com>
References: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
	<20110715205954.GR3834@infomag.iguana.be>
	<20110718094409.GQ23270@n2100.arm.linux.org.uk>
	<20110719131508.GA30207@elliptictech.com>
Message-ID: <20110722183146.GE31767@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick, Russel,

> > > looks good at first glance.
> > > 
> > > Russel: what's your opinion?
> > 
> > Win,
> > 
> > This series looks fine.  However, looking through the driver, there's
> > a few oddities:
> 
> Indeed, there are likely several other ways in which this driver can be
> improved.  My goal was to get it working on our board first. :)

Feel free to continue improving the driver like Russel suggested. :-)

> So if this series is fine, I'll submit #1 (the V2M patch) to Russel's
> patch tracker.  I suppose #2 and #3 should go through the watchdog tree?

I added patch 2 and 3 to linux-2.6-watchdog-next. You can send #1 to 
Russel's patch tracker.

Kind regards,
Wim.
