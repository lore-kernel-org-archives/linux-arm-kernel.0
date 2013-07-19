From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 11:29:04 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v5
In-Reply-To: <51E7379A.1080408@renesas.com>
References: <20130717204918.30125.40588.sendpatchset@w520>
 <51E7379A.1080408@renesas.com>
Message-ID: <20130719022904.GG4403@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 09:32:26AM +0900, Shinya Kuribayashi wrote:
> On 7/18/2013 5:49 AM, Magnus Damm wrote:
> >  Changes since v4:
> >  - Rolled in the following patches from Kuribayashi-san, thanks!
> >    ARM: shmobile: smp-r8a7790: remove the obsolete RESCNT register
> >    ARM: shmobile: smp-r8a7790: rename s/carescnt/rescnt/g
> >    ARM: shmobile: smp-r8a7790: rename s/cabar/bar/g as well
> >    ARM: shmobile: smp-r8a7790: power up a CPU core at .smp_boot_secondary stage
> > 
> >  Written against kernel.org renesas git tag renesas-devel-20130717
> 
> Thanks for the update, looks good to me.

Thanks.

This seems like it is ready to queue-up.
Magnus, are there any outstanding reviews or issues?
