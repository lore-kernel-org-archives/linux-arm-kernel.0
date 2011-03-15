From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 15 Mar 2011 08:59:09 +0200
Subject: [PATCH v2 0/3] Harmony PCI-e and regulators
In-Reply-To: <cover.1299680416.git.mike@compulab.co.il>
References: <cover.1299680416.git.mike@compulab.co.il>
Message-ID: <4D7F0E3D.1090005@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any update on this?

On 03/09/11 16:31, Mike Rapoport wrote:
> These patches provide update for Harmony PCI-e intialization and add
> registration of the TPS65862 PMIC.
> Additionally, there are several tegra_defconfig updates. These updates
> allow booting the Harmony with PCI-e enabled and add ability to boot
> TrimSlice with root on NFS.
> 
> v2 changes:
>    * rework the TPS65862 PMIC initialization as suggested by Mark
>    * rebase the patches on top of Olof's board-for-next branch
> 
> Mike Rapoport (3):
>   ARM: tegra: harmony: update PCI-e initialization sequence
>   ARM: tegra: harmony: initialize the TPS65862 PMIC
>   ARM: tegra: update defconfig
> 
>  arch/arm/configs/tegra_defconfig          |   12 +++-
>  arch/arm/mach-tegra/Makefile              |    1 +
>  arch/arm/mach-tegra/board-harmony-pcie.c  |   24 ++++++-
>  arch/arm/mach-tegra/board-harmony-power.c |  117 +++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/board-harmony.c       |    1 +
>  arch/arm/mach-tegra/board-harmony.h       |    1 +
>  6 files changed, 153 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/board-harmony-power.c
> 


-- 
Sincerely yours,
Mike.
