From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 21:51:11 -0500
Subject: [PATCH v3 0/5] Minor fixes for Marvell Armada 38x SoC.
In-Reply-To: <1415980652-7429-1-git-send-email-mw@semihalf.com>
References: <1415980652-7429-1-git-send-email-mw@semihalf.com>
Message-ID: <20141122025111.GQ22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:57:27PM +0100, Marcin Wojtas wrote:
> Hello,
> 
> It seems that my server at work is not properly configured to be accepted by
> LAKML. Now everything should be ok.
> 
> Changes from v2:
> * Add 'Acked-by: Andrew Lunn <andrew@lunn.ch>' information to the commit logs
> 
> Changes from v1:
> * Improve commit log with better justification for changing ethernet
>   aliases format in Armada 38x Device Tree
> 
> This patchset adds minor fixes for Armada 38x SoC around SDHCI interface. It
> also enables usage of I2C char-device and adjusts ethernet aliases for
> bootloader's needs. Any feedback is welcome.
> 
> 
> Marcin Wojtas (5):
>   ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC in v7 defconfig
>   ARM: mvebu: enable no-1-8-v flag for Armada 385 DB SDHCI interface
>   ARM: mvebu: remove clock-frequency from Armada 38x SDHCI Device Tree
>     node
>   ARM: mvebu: adjust ethernet aliases according to U-Boot requirements
>     for A38x
>   ARM: mvebu: enable i2c device in mvebu_v7_defconfig
> 
>  arch/arm/boot/dts/armada-385-db.dts | 2 +-
>  arch/arm/boot/dts/armada-38x.dtsi   | 6 +++---
>  arch/arm/configs/mvebu_v7_defconfig | 2 ++
>  3 files changed, 6 insertions(+), 4 deletions(-)

Patches 1 and 5 applied to mvebu/defconfig, 2-4 applied to mvebu/dt.

thx,

Jason.
