From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:31:39 -0700
Subject: [GIT PULL 7/7] Broadcom drivers changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-7-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
 <20170613201044.9808-7-f.fainelli@gmail.com>
Message-ID: <20170619033139.GK30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 01:10:44PM -0700, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/drivers
> 
> for you to fetch changes up to 1f6ab20f5527a2483d666d2ce996c51368d1b617:
> 
>   soc: brcmstb: enable drivers for ARM64 and BMIPS (2017-06-12 10:25:16 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM/ARM64 SoCs specific driver changes for
> 4.13, please pull the following:
> 
> - Doug adds support for the latest generation GISB bus arbiter (v7), he starts by
>   fixing two issues in how registers are written, and how 64-bit addresses are captured
>   and then he simplifies the error interception by using notifiers, which allows him
>   to add support for ARM64
> 
> - Markus updates the SOC_BRCMSTB Kconfig depends to cover ARM64 and BMIPS_GENERIC
>   systems where this code is now also used
> 
> ----------------------------------------------------------------
> Doug Berger (6):
>       bus: brcmstb_gisb: Use register offsets with writes too
>       bus: brcmstb_gisb: correct support for 64-bit address output
>       bus: brcmstb_gisb: add notifier handling
>       bus: brcmstb_gisb: remove low-level ARM hooks
>       bus: brcmstb_gisb: enable driver for ARM64 architecture
>       bus: brcmstb_gisb: update to support new revision
> 
> Markus Mayer (1):
>       soc: brcmstb: enable drivers for ARM64 and BMIPS

Merged, thanks.


-Olof
