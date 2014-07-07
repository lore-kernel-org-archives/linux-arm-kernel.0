From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:03:07 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Header Cleanup for v3.17
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <20140707000307.GE5539@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 11:24:52AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC header cleanup for v3.17.
> 
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-header-cleanup-for-v3.17
> 
> for you to fetch changes up to 62872989bdbf1245d7239b9f4c05a8ee7c775ed5:
> 
>   ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09:40 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Header Cleanup for v3.17
> 
> Move the most common shared header files for mach-shmobile
> from <mach/foobar.h> to "foobar.h"
> 
> 6287298 ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
> 585c09d ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
> 6b8b0cb ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
> fd44aa5 ARM: shmobile: Move common.h
> b6bab12 ARM: shmobile: Move most of irqs.h, keep some for pinctl
> ad6ffa0 ARM: shmobile: Move clock.h
> 74ac0de ARM: shmobile: Move dma-register.h
> 6200e2c ARM: shmobile: Move intc.h, cleanup sh_intc.h usage

Listing the patches and the SHAs in the tag description makes no sense.

(Merged into next/cleanup after taking out the above).


-Olof
