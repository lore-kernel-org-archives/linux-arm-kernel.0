From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Jan 2017 19:13:20 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.11
In-Reply-To: <cover.1483701293.git.horms+renesas@verge.net.au>
References: <cover.1483701293.git.horms+renesas@verge.net.au>
Message-ID: <20170110031320.GE22261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 12:18:10PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC defconfig updates for v4.11.
> 
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.11
> 
> for you to fetch changes up to e37278d83e348eb53029452e65892780359b6bea:
> 
>   ARM: multi_v7_defconfig: Enable r8a774[35] SoCs (2017-01-03 10:44:04 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v4.11
> 
> Enable:
> * Recently added Enable r8a774[35] SoCs
> * CMA for DMA to allow use of VIN with large frame sizes
> * CONFIG_VIDEO_ADV7604 to allow use of HDMI input

Merged into next/defconfig. Thanks.


-Olof
