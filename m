From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 17:04:00 +0000
Subject: [GIT PULL 3/6] omap device tree updates for v3.8 merge window
In-Reply-To: <0MaLIe-1TsCr93bz6-00K6Wu@mx.kundenserver.de>
References: <0MaLIe-1TsCr93bz6-00K6Wu@mx.kundenserver.de>
Message-ID: <201211151704.00309.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 November 2012, Tony Lindgren wrote:
> The following changes since commit edf8dde393f879fc2d8c22d4bc01ff8d37b80e1a:
> 
>   Merge branch 'linus' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-09 14:58:01 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/dt-signed
> 
> for you to fetch changes up to d308ba50a1234b299a00e63a95e61fdeb2f1a2df:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)
> 
> ----------------------------------------------------------------
> 
> Device tree related changes for omaps updating the
> various .dts files, and timer related changes to allow
> configuring the timer via device tree.

I've ended up pulling the prcm cleanup into this branch as well, in order
to resolve a conflict where we add a new machine descriptor here and the
other branch changes all machine descriptors not to use 
omap_prcm_restart.

	Arnd
