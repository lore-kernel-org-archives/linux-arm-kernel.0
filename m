From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jun 2016 22:45:05 -0700
Subject: [GIT PULL 3/7] Broadcom devicetree changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-3-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <1466128575-5378-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160620054505.GF2329@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:56:11PM -0700, Florian Fainelli wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/devicetree
> 
> for you to fetch changes up to 2df1808dc0e2b5358e13beb95192b15200017776:
> 
>   ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC (2016-06-13 12:44:46 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Device Tree changes for Broadcom ARM-based SoCs:
> 
> - Chris provides documentation and DTS fixes for the bcm11351 CPU enable-method in preparation
>   for adding support for the BCM23550 SoC and its corresponding documentation, SoC dtsi
>   and the Sparrow board DTS file
> 
> - Jon adds MSI support to the PCI nodes, updates the secondary cores boot address for the B0
>   production revision of the Northstar Plus SoC, adds a DTS for the BCM958625HR board, another
>   one for the BCM958525XMC board, and finally adds the PL330 DMA controller to the NSP DTS
> 
> - Rafal enables the SPI NOR flash on dual flash systems (NAND + SPI) on the BCM5301x SoCs
>   and devices
> 
> - Florian adds support for the BCM5301x built-in Ethernet switch by adding nodes for the
>   Gigabit MAC controllers and the Switch Register Access block, and finally updates the
>   SmartRG SR-400AC board with its switch port layout
> 

Good tag text, thanks! Merged.


-Olof
