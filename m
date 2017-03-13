From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 15:12:24 -0700
Subject: [GIT PULL] Broadcom devicetree fixes for 4.11
In-Reply-To: <20170306013240.21734-1-f.fainelli@gmail.com>
References: <20170306013240.21734-1-f.fainelli@gmail.com>
Message-ID: <20170313221224.GD13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 05, 2017 at 05:32:40PM -0800, Florian Fainelli wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree-fixes
> 
> for you to fetch changes up to 0c2bf9f95983fe30aa2f6463cb761cd42c2d521a:
> 
>   ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags (2017-03-05 17:10:55 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree fixes for 4.11,
> please pull the following:
> 
> - Jon fixes the UART output on the Broadcom bcm953012k reference board by
>   using the proper clock reference instead of hard-coding the baud rate
> 
> - Jon also fixes the memory map on the bcm953012k reference board by using
>   the appropriate physical RAM start address
> 
> - Jon finally fixes the interrupt type for the Cortex A9 global and local
>   timers found in the BCM5301X SoC (Norsthar).

Olof merges the pull request.


-Olof
