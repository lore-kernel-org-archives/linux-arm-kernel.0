From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 11 Feb 2012 00:42:39 +0100
Subject: [GIT PULL] Samsung EXYNOS pm domains for devel
In-Reply-To: <201202102334.29545.arnd@arndb.de>
References: <010a01cce7e2$438f6d40$caae47c0$%kim@samsung.com>
 <201202102305.45710.rjw@sisk.pl> <201202102334.29545.arnd@arndb.de>
Message-ID: <201202110042.39803.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, February 11, 2012, Arnd Bergmann wrote:
> On Friday 10 February 2012, Rafael J. Wysocki wrote:
> > On Friday, February 10, 2012, Kukjin Kim wrote:
> > > Hi Arnd, Olof,
> > > 
> > > Please pull samsung exynos pm domains.
> > > 
> > > It has been merged into linux-pm tree by Rafael and I think it should be
> > > pulled into arm-soc.
> > 
> > No, this doesn't work like this.  A single patchset is not expected to be
> > present in two different trees at a time.
> 
> We've been doing this for a number of other branches and I see nothing wrong
> with this approach as long as we can rely on both trees not to rebase the
> patches so the commit IDs remain stable.
> 
> Rafael, do you want to keep the option of rebasing the patches that you
> got from Kukjin?

No, I'm not going to rebase them.

> If your workflow requires that, I can't take them, but
> if you can guarantee that the branch you have pulled them into is stable,
> I would prefer to pull it into a branch of arm-soc so that we can have
> other branches based on that where needed to avoid conflicts.

OK, the relevant branch is linux-pm/pm-domains and it won't be rebased.
Please feel free to pull from it.

Thanks,
Rafael
