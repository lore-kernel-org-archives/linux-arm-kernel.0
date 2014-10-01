From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Oct 2014 09:17:21 -0700
Subject: [GIT PULL] some more Rockchip clock changes for 3.18
In-Reply-To: <4728187.K4l757xGSs@phil>
References: <4728187.K4l757xGSs@phil>
Message-ID: <20141001161721.GA11708@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 03:11:14PM +0200, Heiko St?bner wrote:
> Hi Mike,
> 
> here is a second pull request for clock changes.
> 
> For the reset handling there was a sort of change in plans. Instead of the
> whole thing going through the -mm tree, there is now an immutable branch at
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/restart-handler-for-v3.18
> 
> providing the core restart changes for trees using it. So this pull includes
> this branch from Guenter as well as the rockchip restart support.
> 
Thanks - I think this makes much more sense than pushing the patches through
Andrew's tree, as it reflects subsystem dependencies on the restart handler
patch series.

Guenter
