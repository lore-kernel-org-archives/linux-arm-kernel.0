From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Mar 2011 11:33:33 +0000
Subject: [PATCH 7/7] ARM: SMDK6410: Update regulator names for debugfs
	compatiblity
In-Reply-To: <022401cbda0d$08d18550$1a748ff0$%kim@samsung.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
	<1299164315-22246-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<022401cbda0d$08d18550$1a748ff0$%kim@samsung.com>
Message-ID: <20110304113333.GB17653@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 10:39:32AM +0900, Kukjin Kim wrote:

> >  /* VDD_UH_MMC, LDO5 on J5 */
> >  static struct regulator_init_data smdk6410_vdduh_mmc __initdata = {

> Mark, there is no '__initdata' in my tree.
> I just applied following changes (/ -> +).

> If any updates/patches, please let me know :)

That's fine, your resolution doesn't seem to have shown up in -next yet
but there's no actual dependency upon that for this change.
