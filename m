From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 6 Dec 2011 22:39:56 +0100
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111205001500.GA10173@opensource.wolfsonmicro.com>
 <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
Message-ID: <201112062239.57001.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 06, 2011, Kukjin Kim wrote:
> Mark Brown wrote:
> > 
> > On Mon, Dec 05, 2011 at 01:15:18AM +0100, Rafael J. Wysocki wrote:
> > > On Monday, December 05, 2011, Mark Brown wrote:
> > 
> > > > It might make sense for it to go via the Samsung tree - the third
> > patch
> > > > depends on it and there's some other stuff going on with the s3c64xx
> > > > power management - so let's see what Kukjin thinks is best.
> > 
> > > OTOH, it will conflict with some patches I have in the works.
> > 
> > Ah, OK - in that case I guess it's sensible if you apply it.  Ideally it
> > could be on a separate branch so it could be cross-merged with other
> > trees if there's a need later.
> 
> Hi Mark and Rafael,
> 
> Looks ok to me on this series and would be nice to me if Rafael could create
> topic branch in his tree and apply this series with my ack for Samsung
> stuff.
> 
> Rafael, please let me know the branch when you create it so that I can merge
> it into Samsung tree to avoid other conflicts.

I need an ack from Magnus or Paul on the shmobile patch. When I get one, I'll
put patches [1/3] and [2/3] (new version) into my linux-next branch and then
(after a few days spent in linux-next) to the pm-domains branch.  I'll let you
know when that happens.

Thanks,
Rafael
