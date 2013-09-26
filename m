From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 27 Sep 2013 04:56:44 +0530
Subject: [GIT PULL] DaVinci SoC updates for v3.13
In-Reply-To: <524228F9.50104@ti.com>
References: <524228F9.50104@ti.com>
Message-ID: <5244C2B4.7060900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wednesday 25 September 2013 05:36 AM, Sekhar Nori wrote:
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
> 
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.13/soc
> 
> for you to fetch changes up to 5093f84e708574142ce26fa4a6c4558176436c86:
> 
>   ARM: edma: dt: create unused channel list (2013-09-25 05:04:28 +0530)
> 
> ----------------------------------------------------------------
> This pull request contains a patch to remove
> a long deprecated irq flag and completes the
> DT support in EDMA library.
> 
> ----------------------------------------------------------------
> Joel Fernandes (1):
>       ARM: edma: dt: create unused channel list

If you are picking Joel's patch "ARM: EDMA: Fix clearing of unused list
for DT DMA resources" for v3.12-rc then this patch can be dropped from
the pull request. Let me know if you want an updated request or will be
able to drop the patch yourself.

Thanks,
Sekhar
