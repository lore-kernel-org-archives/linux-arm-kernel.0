From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 15:17:20 +0000
Subject: [PATCH V6 5/5] arm: mvebu: Add SMP support for Armada XP
In-Reply-To: <1353509970-5237-6-git-send-email-gregory.clement@free-electrons.com>
References: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
 <1353509970-5237-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121121151720.GP11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 02:59:30PM +0000, Gregory CLEMENT wrote:
> This enables SMP support on the Armada XP processor. It adds the
> mandatory functions to support SMP such as: the SMP initialization
> functions in platsmp.c, the secondary CPU entry point in headsmp.S and
> the CPU hotplug initial support in hotplug.c.
> 
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig    |    3 +
>  arch/arm/mach-mvebu/Kconfig         |    1 +
>  arch/arm/mach-mvebu/Makefile        |    2 +
>  arch/arm/mach-mvebu/armada-370-xp.c |    3 +
>  arch/arm/mach-mvebu/common.h        |    3 +
>  arch/arm/mach-mvebu/headsmp.S       |   49 ++++++++++++++
>  arch/arm/mach-mvebu/hotplug.c       |   30 +++++++++
>  arch/arm/mach-mvebu/platsmp.c       |  122 +++++++++++++++++++++++++++++++++++
>  8 files changed, 213 insertions(+)
>  create mode 100644 arch/arm/mach-mvebu/headsmp.S
>  create mode 100644 arch/arm/mach-mvebu/hotplug.c
>  create mode 100644 arch/arm/mach-mvebu/platsmp.c

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
