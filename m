From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Nov 2014 16:11:36 +0100
Subject: [PATCH v2 RESEND 0/5] Minor fixes for Marvell Armada 38x SoC.
In-Reply-To: <1415965304-83520-1-git-send-email-mw@semihalf.com>
References: <1415965304-83520-1-git-send-email-mw@semihalf.com>
Message-ID: <20141114151136.GF31881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 12:41:39PM +0100, Marcin Wojtas wrote:
> Hello,
> 
> I'm sorry for excessive emails with the patches, but I have to re-send them due
> to some problems with getting accepted by the list.

I don't think they made it through this time either :-(

Are you getting any message from the listserver about what it does not
like? I know i've had trouble with UTF8 characters in patches...

Anyway, they seem O.K. to me. Please add

Acked-by: Andrew Lunn <andrew@lunn.ch>

before you try again.

       Andrew

> 
> Changes from v1:
> * improve commit log with better justification for changing ethernet
>   aliases format in Armada 38x Device Tree
> 
> This patchset adds minor fixes for Armada 38x SoC around SDHCI interface. It
> also enables usage of I2C char-device and adjusts ethernet aliases for
> bootloader's needs. Any feedback is welcome.
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
> 
> -- 
> 1.8.3.1
> 
