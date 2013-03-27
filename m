From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 27 Mar 2013 05:54:21 -0300
Subject: [PATCH for 3.10 0/4] thermal: Add Armada 370/XP support
In-Reply-To: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130327085420.GA2465@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Mar 25, 2013 at 12:27:05PM -0300, Ezequiel Garcia wrote:
> After Andrew Lunn objected the single driver approach [1] that merged
> all the Marvell EBU SoC thermal drivers, we have agreed to proceed step
> by step. For the time being we are adding support for Armada 370/XP only.
> Given both Armada 370 and Armada XP have a similar feature set, it
> makes sense to provide a single driver for them.
> 
> In the future we can unify this with the other drivers,
> if this proves to be worthwhile.
> 
> This driver has been influenced by the existing Kirkwood driver,
> also taking account of suggestions made by Jason Gunthorpe.
> 
> Testing has been done on the following boards:
> 
> For Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
> For Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP-GP
> 
> This series is based in v3.9-rc2. To make testing easier this patchset
> has been pushed on a github branch [2].
> 
> Any feedback or comments are welcome!
> 
> [1] http://permalink.gmane.org/gmane.linux.power-management.general/32123
> [2] https://github.com/MISL-EBU-System-SW/mainline-public/tree/armada-thermal

Now that Andrew Lunn has acked this series...

> 
> Ezequiel Garcia (4):
>   thermal: Add driver for Armada 370/XP SoC thermal management

@Zhang: If nobody else has any comments regarding this, would you take
the first patch through your tree?

>   ARM: mvebu: Add thermal support to Armada XP device tree
>   ARM: mvebu: Add thermal support to Armada 370 device tree
>   ARM: configs: Update mvebu defconfig for thermal

@Jason: if Zhang agrees to take the first patch, would you take the rest?

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
