From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Thu, 2 Dec 2010 00:34:12 +0530
Subject: [PATCH v5 00/14] OMAP: DMA: hwmod and DMA as platform device
In-Reply-To: <20101125112811.GA27574@GLPP-machine>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<20101125112811.GA27574@GLPP-machine>
Message-ID: <20101201190412.GA8149@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony/Kevin,

* G, Manjunath Kondaiah <manjugk@ti.com> [2010-11-25 16:58:11 +0530]:

> Kevin,
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [2010-11-24 18:21:36 +0530]:
> 
> > Patch series to convert DMA library into platform driver using platform
> > device model and adapting hwmod for omap2+.
> > 	
> [...]
> > 
> > Patch series applies on top of latest linux omap master branch:
> > *************************************************************************
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > Branch: master
> > commit 25f7615faa843731af4eda7d05077f1c5132e1a9
> > Merge: 784bee8 8973a21
> > Author: Tony Lindgren <tony@atomide.com>
> > 
> >     Linux-omap rebuilt: Updated to -rc3
> > *************************************************************************
> 
> It also applies cleanly on top of:
> 
> *************************************************************************
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Branch: pm-core
> commit 8bcd9727ee126dc50093e84f19dd6c118842202f
> Merge: 632dd87 25f7a1d
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> 
>     Merge branch 'pm-hacks' into pm-reset
>   
> *************************************************************************
Do you have any further comments for this series?

-Manjunath
[...]
