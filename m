From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Fri, 12 Aug 2011 17:58:00 +0200
Subject: [GIT PULL] samsung: fixes for v3.1-rc1
In-Reply-To: <015001cc57f5$d7e847f0$87b8d7d0$%kim@samsung.com>
References: <20110811065837.GA4989@july>
	<015001cc57f5$d7e847f0$87b8d7d0$%kim@samsung.com>
Message-ID: <201108121758.01077.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 August 2011, Kukjin Kim wrote:
> >   Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/kmpark/linux-2.6-samsung for-arnd
> > 

> No, if above is required, I think, this should be handled from me not you.
> 
> Don't make a complete confusion between your board and Samsung architecture
> maintainer.

I'll hold off on pulling this one then until I get another pull request
from you.

Looking at the contents of the branch, I noticed that it's not clear why
they are needed in 3.1. It would help me if you (whoever sends me the bug
fixes) can categorize them in the changelog:

* Any bug fixes against old bugs should be marked 'Cc: stable at kernel.org'
so that they can get identified for backports.

* Regressions against the 3.0 kernel should get marked as such.

* Bug fixes against new code should also be identified as such.

	Arnd
