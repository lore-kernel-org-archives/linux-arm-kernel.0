From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Nov 2012 22:54:17 -0800
Subject: [GIT PULL 2/3] omap late prcm changes for v3.8 merge window
In-Reply-To: <50b41208.4989e50a.26c2.ffffba54SMTPIN_ADDED_MISSING@mx.google.com>
References: <pull-1353978372-642963>
 <50b41208.4989e50a.26c2.ffffba54SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20121130065417.GC6899@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
> The following changes since commit 558a0780b0a04862a678f7823215424b4e5501f9:
> 
>   Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/devel-prcm-signed
> 
> for you to fetch changes up to 8b9c1ac2e11a9fb3a5a8860fb7570ff7633aa7f7:
> 
>   Merge tag 'omap-devel-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/devel-pcrm (2012-11-26 12:32:50 -0800)

Thanks, pulled. Dependencies are getting to be a bit complex for omap stuff at
this point, so I merged it into a new next/pm2 branch. It's not unlikely that
we will combine next/pm, next/clock and next/pm2 into one branch before merging
upstream, since there are lots of internal dependencies between those.


-Olof
