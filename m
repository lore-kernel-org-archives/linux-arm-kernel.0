From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 17:32:54 -0400
Subject: [PATCH v2 0/3] ARM: mvebu: enable SDHCI interface on Armada 38x
In-Reply-To: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140425213254.GE28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:41:15PM +0200, Thomas Petazzoni wrote:
> Jason, Gregory, Andrew, Sebastian,
> 
> Here is a small set of patches that enable the SDHCI interface on
> Armada 38x. The first one adds the DT details, the second and third
> ones adjusts the appropriate defconfigs to include the relevant
> driver.
> 
> The sdhci-pxav3 driver change has been taken by the MMC maintainer
> Chris Ball, and is already in 3.15-rc1.
> 
> Changes since v1:
> 
>  * Rebased on top of v3.15-rc1.
> 
>  * Split in two commits the defconfig changes, so that the
>    multi_v7_defconfig change can be directly taken by the arm-soc
>    maintainers.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   ARM: mvebu: enable the SDHCI interface on Armada 385
>   ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the mvebu_v7_defconfig
>   ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the multi_v7_defconfig

Applied patch 1 to mvebu/dt, 2 to mvebu/defconfig, and I'll Ack #3.

Also included Andrew's Ack

thx,

Jason.
