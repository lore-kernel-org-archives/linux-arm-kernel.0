From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 13 Jul 2011 11:04:16 +0530
Subject: [GIT PULL] DaVinci fix for v3.0
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7B3D7@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7B3D7@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7B3E0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 10:59:47, Nori, Sekhar wrote:
> Hi Arnd,
> 
> Can you please pull this late breaking DaVinci fix for v3.0?
> This is fallout of generic irq chip migration and prevents GPIO
> interrupts from functioning correctly.

Resent with fixed DaVinci Linux mailing list address.

Thanks,
Sekhar

> 
> The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
>   Linus Torvalds (1):
>         Linux 3.0-rc7
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-davinci/linux-davinci.git fixes
> 
> Ido Yariv (1):
>       arm: davinci: Fix low level gpio irq handlers' argument
> 
>  arch/arm/mach-davinci/gpio.c |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
