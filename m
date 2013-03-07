From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 17:53:33 +0100
Subject: [PATCH 5/5] ARM: mvebu: Update defconfig to select Device Bus
 (memory-controller) support
In-Reply-To: <1362660865-2755-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1362660865-2755-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130307175333.1a0e6541@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu,  7 Mar 2013 09:54:25 -0300, Ezequiel Garcia wrote:
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 2ec8119..70a65f9 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -65,6 +65,8 @@ CONFIG_RTC_DRV_S35390A=y
>  CONFIG_RTC_DRV_MV=y
>  CONFIG_DMADEVICES=y
>  CONFIG_MV_XOR=y
> +CONFIG_MEMORY=y
> +CONFIG_MVEBU_DEVBUS=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y

I think it would be great if you also selected the relevant MTD drivers
to enable access to the NOR flashes available in the Armada XP GP and
PlatHome OpenBlocks AX3 boards.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
