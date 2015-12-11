From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 00:21:32 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.5
In-Reply-To: <cover.1448585673.git.horms+renesas@verge.net.au>
References: <cover.1448585673.git.horms+renesas@verge.net.au>
Message-ID: <1650671.Xh9EhEssTx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 10:55:47 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC cleanup for v4.5.
> 
> This pull request includes some minor cleanups and
> introduces ARCH_RENESAS as a firs step to migrating away
> from ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI.
> 
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.5
> 
> for you to fetch changes up to c8cd74a1468ffe20db3ddc6e6f408d5377f9be43:
> 
>   ARM: shmobile: Remove legacy mach/irqs.h (2015-11-19 16:28:01 -0800)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Cleanup for v4.5
> 
> * Remove now unnecessary header
> * Introduce ARCH_RENESAS
> * Remove unmaintened URL from MAINTAINERS
> 

Pulled into next/cleanup, one conflict gone from linux-next.

Thanks,

	Arnd
