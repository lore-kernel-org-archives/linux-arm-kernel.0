From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Oct 2015 21:48:51 +0800
Subject: [PATCH v2 0/3] arm:irchip: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <1444740975-31948-1-git-send-email-joel@porquet.org>
References: <1444740975-31948-1-git-send-email-joel@porquet.org>
Message-ID: <20151013134851.GA551@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 02:56:12PM +0200, Joel Porquet wrote:
> The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> globally accessible.
> 
> See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d ("irqchip: Move
> IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> 
> This series of patches add inclusions of 'include/linux/irqchip.h' and
> replaces uses of macro OF_DECLARE_2 with IRQCHIP_DECLARE for platforms
> exynos, imx and omap2.
> 
> I had submitted a single patch a few months ago
> (https://lkml.org/lkml/2015/7/7/1069), but it never got merged although it
> had been acked by all the subsystem maintainers. Hopefully, splitting the
> patch into these independent patches that can be applied separately should
> help.
> 
> Jo?l
> 
> Joel Porquet (3):
>   arm:exynos: IRQCHIP_DECLARE macro is now accessible
>   arm:imx: IRQCHIP_DECLARE macro is now accessible
>   arm:omap2: IRQCHIP_DECLARE macro is now accessible
> 
>  arch/arm/mach-exynos/suspend.c       | 3 ++-
>  arch/arm/mach-imx/gpc.c              | 7 ++-----
>  arch/arm/mach-omap2/omap-wakeupgen.c | 7 ++-----
>  3 files changed, 6 insertions(+), 11 deletions(-)

Marc sent a patch [1] doing the same thing a few days ago.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/444136
