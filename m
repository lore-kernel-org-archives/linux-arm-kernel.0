From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 11 Oct 2012 12:47:22 +0000
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <5076B166.2020006@gmail.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Oct 11, 2012 at 17:15:42, Daniel Mack wrote:

> Admittedly, I lost track on the multiple GPMC series here, and they also
> cause major merge conflicts with Linus' current master branch.
> 
> Could you tell me which patches I need on top of soon-to-be-3.7-rc1? I

Series [1-2] plus this series would be the required.
Note that 1st patch of series [2] has already reached mainline.

Another easy way would be, pull,
git://gitorious.org/x0148406-public/linux-kernel.git gpmc-timing

git checkout -b gpmc <myremote/gpmc-timing>
git rebase --onto <Linus-current-master> next-20121005 (or "080aa9c")

> would like to augment this to make GPMC attached NAND probable in DT, in
> case this is still an open topic.

I would be doing gpmc DT conversion next. Hoping that this
series too will be picked up by Tony, as once this series is
accepted, during DT conversion we need not rely on
auxdata (a last resort option) for timings.

> Thanks for you hard work,

Thanks, it was a pleasure to read the above.

Regards
Afzal

[1] http://marc.info/?l=linux-omap&m=134945131602622&w=2
[2] http://marc.info/?l=linux-omap&m=134967458329531&w=2
