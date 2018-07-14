From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:11:22 -0700
Subject: [GIT PULL 3/6] Broadcom devicetree changes for 4.19
In-Reply-To: <20180709153035.6376-3-f.fainelli@gmail.com>
References: <20180709153035.6376-1-f.fainelli@gmail.com>
 <20180709153035.6376-3-f.fainelli@gmail.com>
Message-ID: <20180714211122.ukjzsgh5nwtxfsx6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 08:30:32AM -0700, Florian Fainelli wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/devicetree
> 
> for you to fetch changes up to 3be77fe8c3f138cbab68d9c745c2038607286b24:
> 
>   Merge tag 'bcm2835-dt-next-2018-07-03' into devicetree/next (2018-07-09 08:12:15 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree changes
> for 4.19, please pull the following:
> 
> - Clement adds ethernet aliases to the Cygnus DTS include file such that
>   a DT aware bootloader such as u-boot can properly insert MAC addresses
> 
> - Mohamed adds a Device Tree node for the HWRNG found on Cygnus SoCs
> 
> - Vivek migrates all the BCM5301x (Northstar) Device Tree sources to use
>   the proper USB 3.0 PHY representation using its parent MDIO bus.
>   Vivek also completes the Linksys EA9500 Device Tree by adding support
>   for LEDs, internal and external switches.
> 
> - Rafal adds the ARM architected timer to the BCM53573 Device Tree
>   include file.
> 
> - Eric adds the Performance Monitoring Unit to the BCM2837 DTS include
>   file since it was absent before
> 
> - Boris adds the BCM283x transposer block to the Device Tree
> 
> - Stefan adds the Raspberry Pi Compute Module (CM1) Device Tree include
>   and sources.

Merged, thanks!


-Olof
