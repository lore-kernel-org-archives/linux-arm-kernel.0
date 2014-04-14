From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Apr 2014 17:24:02 +0200
Subject: [PATCH v2 0/3] ARM: mvebu: enable SDHCI interface on Armada 38x
In-Reply-To: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140414152402.GE22546@lunn.ch>
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


Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
