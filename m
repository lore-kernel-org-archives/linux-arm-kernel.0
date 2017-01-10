From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Jan 2017 19:16:42 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.11
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <20170110031642.GG22261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 12:18:31PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.11.
> 
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.11
> 
> for you to fetch changes up to 654450baf2afba86cf328e1849ccac61ec4630af:
> 
>   ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for msiof nodes (2017-01-03 10:47:05 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.11
> 
> * Add da9063 PMIC device node for system restart to gose board
> * Add device node for PRR to SoCs where it was missing
> * Move RST node before SYSC node where it was incorrectly placed
> * Use Gen 2 fallback bindings for I2C, IIC, MSIOf and USB2 phy
> * Use SoC-specific compat string for MMCIF where it was missing

Merged, thanks.


-Olof
