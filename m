From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jun 2017 15:42:29 -0700
Subject: [GIT PULL 2/7] Broadcom devicetree changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-2-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
 <20170613201044.9808-2-f.fainelli@gmail.com>
Message-ID: <8f830522-45fb-c86e-0b0e-6af95d793828@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 01:10 PM, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree
> 
> for you to fetch changes up to 4a579ecf3d4f964bd6b39605610201cd4d5a7e8e:
> 
>   Merge tag 'bcm2835-dt-next-2017-06-12' into devicetree/next (2017-06-13 12:38:48 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based Device Tree changes for 4.13.
> 
> Note that Baruch's changes are fixes that are currently included in v4.12-rc2,
> but they are also included here in order to keep this tag based off v4.12-rc1.
> 
> Please pull the following:
> 
> - Rafal adds CPU and thermal zones to the Northstar (BCM5301X) Device Tree and he
>   also adds the MDIO controller nodes for later use by USB PHYs
> 
> - Eric adds support for the V3D engine and Ethernet switch on the Cygnus
>   platforms, he also adds a set of Device Tree sources and include files for the
>   Raspberry Pi 3 (BCM2837) to be used with the ARM/Linux kernel,
> 
> - Jon adds CPU and thermal zones to the Northstar Plus Device Tree files
> 
> - Stefan updates the Raspberry Pi DTS files with thermal trip points and zones,
>   adds support for the USB OTG on the Raspberry Pi Zero which includes the
>   proper dwc2 configuration, a generic USB PHY and finally the enabling of the
>   OTG controller by including the proper DTS include file
> 
> - Gerd switches the Raspberry Pi DTS files to use the SDHOST controller (faster
>   than the SDHCI)
> 
> ----------------------------------------------------------------

Same here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=brcm/dt
-- 
Florian
