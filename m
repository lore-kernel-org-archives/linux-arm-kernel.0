From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Dec 2013 15:55:34 -0800
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14 (incr. #4)
In-Reply-To: <20131217142222.GI2609@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 17 Dec 2013 09:22:22 -0500")
References: <20131217142222.GI2609@titan.lakedaemon.net>
Message-ID: <87haa4iefd.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> Guys,
>
> Here's the fourth round of DT changes in mvebu-land.  This one completes
> a long-standing item on my todo list.  It's been in -next for four days,
> and it's purely a sort.
>
> As with the previous pull requests, this is an incremental pull on the
> mvebu/dt branch from tags/mvebu-dt-3.14-3 to tags/mvebu-dt-3.14-4.
>
> thx,
>
> Jason.
>
>
> The following changes since commit 69e18e26b5773092276a9702244784faf9b6c65f:
>
>   ARM: mvebu: Enable NAND controller in A370 Reference Design board (2013-12-12 14:04:34 +0000)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14-4
>
> for you to fetch changes up to a095b1c78a35f05755ca2f0e106d84792974aef5:
>
>   ARM: mvebu: sort DT nodes by address (2013-12-12 15:00:44 +0000)
>
> ----------------------------------------------------------------
> mvebu DT changes for v3.14 (incremental #4)
>
>  - mvebu/orion5x/dove/kirkwood
>     - sort nodes on ocp bus by address
>
> ----------------------------------------------------------------

Pulled into next/dt.

Thanks,

Kevin
