From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:21:36 +0900
Subject: [PATCH 0/1] ARM: shmobile: r8a73a4 thermal support
In-Reply-To: <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130327052135.GK25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 11:17:06PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus
> 
> This patch add thermal driver support on r8a73a4.
> 
> > ARM: shmobile: r8a73a4 SoC support V3
> > [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
> > [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
> > [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
> > [PATCH 04/04] ARM: shmobile: r8a73a4 PFC support
> 
> This patch is based on...
> 
> simon/next branch
> 
> And, Magnus's
>     ARM: shmobile: r8a73a4 SoC support V3
>     sh-pfc: Initial r8a73a4 PFC support
>     ARM: shmobile: r8a73a4 APE6EVM board support V2
> 
> And, Zhang's (= PM ML)
> 
> f0e68fc3caf677e834f7bd0f601800e686b56c98
> (thermal: rcar: fix missing unlock on error in rcar_thermal_update_temp())
> 
> fb84d9907f0ff0e3f7d70d55039ddf0f78d2a472
> (thermal: rcar_thermal: propagate return value of thermal_zone_device_register)
> 
> And, my previous
>       thermal: rcar: tidyup registration failure case
>       thermal: rcar: add pm_runtime_xxx() support
> 
> Simon, please let me know if you need my help

I think that I need to get a branch to base my changes on.
Do you know if such a branch exists and who we should contact
to make sure it is ok to use it as a base?
