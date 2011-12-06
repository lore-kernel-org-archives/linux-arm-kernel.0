From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Dec 2011 19:20:08 +0900
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <20111205001500.GA10173@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112042156.59990.rjw@sisk.pl>
 <20111204231005.GA4255@opensource.wolfsonmicro.com>
 <201112050115.18489.rjw@sisk.pl>
 <20111205001500.GA10173@opensource.wolfsonmicro.com>
Message-ID: <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Mon, Dec 05, 2011 at 01:15:18AM +0100, Rafael J. Wysocki wrote:
> > On Monday, December 05, 2011, Mark Brown wrote:
> 
> > > It might make sense for it to go via the Samsung tree - the third
> patch
> > > depends on it and there's some other stuff going on with the s3c64xx
> > > power management - so let's see what Kukjin thinks is best.
> 
> > OTOH, it will conflict with some patches I have in the works.
> 
> Ah, OK - in that case I guess it's sensible if you apply it.  Ideally it
> could be on a separate branch so it could be cross-merged with other
> trees if there's a need later.

Hi Mark and Rafael,

Looks ok to me on this series and would be nice to me if Rafael could create
topic branch in his tree and apply this series with my ack for Samsung
stuff.

Rafael, please let me know the branch when you create it so that I can merge
it into Samsung tree to avoid other conflicts.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
