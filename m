From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Jan 2017 16:25:26 -0800
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.11 (try 2)
In-Reply-To: <20170119012553.2844-1-f.fainelli@gmail.com>
References: <20170119003025.GL23725@localhost>
 <20170119012553.2844-1-f.fainelli@gmail.com>
Message-ID: <20170120002526.GB685@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 05:25:53PM -0800, Florian Fainelli wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree
> 
> for you to fetch changes up to c5a8e3add28ca4063410353acfbe6e650174e432:
> 
>   Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next (2017-01-18 17:20:32 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree changes for 4.11,
> please pull the following changes:
> 
> - Rafal enables the UART by default on all BCM5301x, BCM4708, BCM4709 since
>   every device found out there has it enabled by default. He also fixes the
>   LED definitions for the Luxul XWR-3100 device, enables USB controllers and
>   their respective PHY devices, specifies the correct GPIO to power on USB
>   HUBs, adds the additional RAM bank for somes devices, and finally sets the
>   correct 5Ghz frequency limits on the Netgear R8000
> 
> - Jon does a number of Norsthar Plus SoC cleanups, fixes NAND partitions unit
>   addresses, adds QSPI support to a bunch of boards, adds Ethernet switch ports
>   to the BCM958625K reference board, enables 3rd Ethernet MAC instance to
>   relevant DTSes, enables Ethernet on the XMC board, and finally adds SD/MMC
>   support to the XMC board
> 
> - Boris adds the Video Encoder nodes to the Raspberry Pi DTS include files
>   ands enables it on the relevant boards
> 
> - Dan adds support for two new Luxul devices: XAP-1410 and XWR-1200, both
>   BCM47081 based SoCs

Merged, thanks!


-Olof
