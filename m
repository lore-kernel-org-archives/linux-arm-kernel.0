From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 4 Apr 2014 11:49:42 -0400
Subject: [PATCH 2/2] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the
 relevant defconfigs
In-Reply-To: <1396626125-8631-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396626125-8631-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140404154942.GD28334@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

My, you've been busy. :)

On Fri, Apr 04, 2014 at 05:42:05PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x platform has a SDHCI interface managed by the
> sdhci-pxav3 MMC host driver. It therefore makes sense to enable this
> driver in both mvebu_v7_defconfig and multi_v7_defconfig, which are
> both capable of building Marvell Armada 38x support.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +

Please make this a separate patch when you rebase against v3.15-rc1.
arm-soc will take it directly since multi_v7_defconfig is so
conflict-prone.

>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  2 files changed, 2 insertions(+)

thx,

Jason.
