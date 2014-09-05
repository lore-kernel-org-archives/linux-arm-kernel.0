From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Sep 2014 18:20:45 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup Updates for v3.18
In-Reply-To: <cover.1408670789.git.horms+renesas@verge.net.au>
References: <cover.1408670789.git.horms+renesas@verge.net.au>
Message-ID: <201409051820.45791.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 August 2014, Simon Horman wrote:
> Please consider these Renesas ARM based SoC cleanup updates for v3.18.
> 
> This pull request is based on
> "Renesas ARM Based SoC DT Timers Updates for v3.18",
> tagged as dt-timers-for-v3.18,
> which I have already sent a pull-request for.
> 
> This is a rebase of changes that didn't quite make it into v3.17.
> These cleanups depend on changes in dt-timers-for-v3.18 and rebasing
> to remove that dependency is not entirely trivial.
> 


I hesitated a bit for this one and the dt-timers-for-v3.18 branch, as they
don't really fit into our scheme, and I'd much prefer having the cleanups
done first, while everything else isn't that important.

In the end, I stuck it all into next/soc.

That's the last one of the outstanding shmobile pull requests that I'm
aware of. Again, sorry for taking my time with them. Please check that
I didn't miss anything you wanted me to pull.

Thanks,

	Arnd
