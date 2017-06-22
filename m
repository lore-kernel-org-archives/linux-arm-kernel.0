From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jun 2017 15:43:28 -0700
Subject: [GIT PULL 3/7] Broadcom devicetree-arm64 changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-3-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
 <20170613201044.9808-3-f.fainelli@gmail.com>
Message-ID: <c7f22782-00d6-1af4-69c8-c4b560ed13bf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 01:10 PM, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree-arm64
> 
> for you to fetch changes up to 39b1aae758de6f933f8b45698b56221f6e817dc9:
> 
>   Merge tag 'bcm2835-dt-64-next-2017-06-08' into devicetree-arm64/next (2017-06-13 12:39:57 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
> 4.13. Please note the following from Eric:
> 
> I've based this summary on the bcm2835-dt-next tag, to clarify what's in this
> patch series, but it does require being careful since it involves a cross-merge
> between branches.
> 
> - Anup documents the Broadcom Stingray binding, common clocks, adds initial
>   support for the Stingray DTSI and DTS files and adds support for the PL022,
>   PL330 and SP805
> 
> - Sandeep adds the clock nodes to the Stingray Device Tree nodes
> 
> - Pramod adds support for the NAND, pinctrl, GPIO to the Stingray Device Tree nodes
> 
> - Oza adds I2C Device Tree nodes to the Stingray DTSes
> 
> - Srinath adds PWM and SDHCI Device Tree nodes for the Stingray SoC
> 
> - Ravijeta adds support for the USB Dual Role PHY on Northstar 2
> 
> - Gerd starts adding references to the sdhost and sdhci controllers, and then
>   switches the sdcard to to use the SDHOST (faster than SDHCI)
> 
> - Stefan defines the BCM2837 thermal coefficients in order for the Raspberry Pi
>   thermal driver to work correctly
> 
> ----------------------------------------------------------------

And here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=brcm/dt64
-- 
Florian
