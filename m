From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2017 16:11:25 -0800
Subject: [GIT PULL] omap fixes for v4.10-rc4
In-Reply-To: <587eb2e1.21d2540a.b610a.992bSMTPIN_ADDED_BROKEN@mx.google.com>
References: <587eb2e1.21d2540a.b610a.992bSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170119001125.GA23725@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 04:12:09PM -0800, Tony Lindgren wrote:
> The following changes since commit 1a38de880992764d4bd5bccbd306b87d860e377d:
> 
>   ARM: dts: am572x-idk: Add gpios property to control PCIE_RESETn (2016-12-30 10:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/fixes-rc4
> 
> for you to fetch changes up to 1ea6af3216b092ec97129ac81bd95cf254c4b140:
> 
>   ARM: dts: omap3: Fix Card Detect and Write Protect on Logic PD SOM-LV (2017-01-17 13:50:55 -0800)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.10-rc cycle. Mostly a DMA regression fix for
> omap1, and then a handful of trivial fixes for boards and devices to
> work:
> 
> - Fixes TI wilink bluetooth strange platform data baud rate
> 
> - Remove duplicate pinmux line for am335x-icev2
> 
> - Fix omap1 dma regression
> 
> - Fix uninitialized return value for wkup_m3_ipc_probe()
> 
> - Fix Ethernet PHY binding typo for dra72-evm
> 
> - Fix init for omap5 and dra7 sata ports
> 
> - Fix mmc card detect pin for Logic PD SOM-LV

Merged, thanks.


-Olof
