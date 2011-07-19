From: nbowler@elliptictech.com (Nick Bowler)
Date: Tue, 19 Jul 2011 09:15:08 -0400
Subject: [PATCH 0/3] SP805 updates for Versatile Express
In-Reply-To: <20110718094409.GQ23270@n2100.arm.linux.org.uk>
References: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
	<20110715205954.GR3834@infomag.iguana.be>
	<20110718094409.GQ23270@n2100.arm.linux.org.uk>
Message-ID: <20110719131508.GA30207@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-07-18 10:44 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 15, 2011 at 10:59:54PM +0200, Wim Van Sebroeck wrote:
> > looks good at first glance.
> > 
> > Russel: what's your opinion?
> 
> Win,
> 
> This series looks fine.  However, looking through the driver, there's
> a few oddities:

Indeed, there are likely several other ways in which this driver can be
improved.  My goal was to get it working on our board first. :)

So if this series is fine, I'll submit #1 (the V2M patch) to Russel's
patch tracker.  I suppose #2 and #3 should go through the watchdog tree?

Thanks,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
