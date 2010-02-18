From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 16:38:23 +0000
Subject: [PATCH] ARM: Fix build error for arm1026ej-s processor
In-Reply-To: <1266424071-24053-1-git-send-email-walsimou@walsimou.com>
References: <1266424071-24053-1-git-send-email-walsimou@walsimou.com>
Message-ID: <20100218163823.GD20243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 05:27:51PM +0100, Abdoulaye Walsimou Gaye wrote:
> This patch fix the below build error for arm1026ej-s processor (IntegratorCP/arm1026ej-s board).
>   CC      init/main.o
> In file included from include/linux/highmem.h:8,
>                  from include/linux/pagemap.h:10,
>                  from include/linux/mempolicy.h:62,
>                  from init/main.c:52:
> arch/arm/include/asm/cacheflush.h:134:2: error: #error Unknown cache maintainence model
> make[1]: *** [init/main.o] Erreur 1
> make: *** [init] Erreur 2

Please submit this to the patch system.

Please add a 'CC: <stable@kernel.org>' to the attributations too, so that it
gets picked up by the stable team.

Thanks.
