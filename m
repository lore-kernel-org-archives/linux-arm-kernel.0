From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 02:08:21 +0100
Subject: [GIT PULL] DaVinci SoC fixes for v3.15
In-Reply-To: <532AD471.5030305@ti.com>
References: <532AD471.5030305@ti.com>
Message-ID: <201403270208.21854.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Sekhar Nori wrote:
> Here is a fix from Kevin over the soc pull request
> sent earlier.
> 
> Thanks,
> Sekhar
> 
> The following changes since commit 4b9e44f8d7c9cd166d8304b8f619741c1d59b836:
> 
>   ARM: davinci: remove da8xx_omapl_defconfig (2014-03-06 19:08:30 +0530)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.15/soc-2
> 
> for you to fetch changes up to b737f51d423861399079a1f66647e7a416de3318:
> 
>   ARM: davinci: fix DT booting with default defconfig (2014-03-20 15:39:38 +0530)
> 
> ----------------------------------------------------------------
> Includes a patch to enable appended
> DTB support for DT booting on DA850
> boards with older bootloaders.
> 

Pulled into next/soc

	Arnd
