From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 12:48:31 -0700
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.7
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <20160413194831.GR19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:23:15AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.7.
> 
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.7
> 
> for you to fetch changes up to 64abfd0a89ae1c7e0edcc6744198842e706c0b52:
> 
>   ARM: dts: r8a7791: Use USB3.0 fallback compatibility string (2016-03-28 09:03:37 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.7
> 
> * Correct interrupt type for ARM TWD in DT of r8a7779 and sh73a0 SoCs
> * Add IIC support to DT of r8a7794 SoC
> * Add CAN support to DT of r8a7793 and r8a7794 SoCs
> * Add SCIF2 support to r8a7790 device tree
> * Reference both DMA controllers in MMCIF, SDHI, QSPI HSCIF, SFIFA, SCIFB
>   and IIC nodes of r8a7790, r8a7791 r8a7793 and r8a7794 SoCs.
> * Use CAN, JPU and USB3.0 fallback compatibility string
>   in DT of r8a7791 and r8a7790 SoCs

Hi,

I had comments on the DMA controller additions, see reply on the specific
patch.

Branch not merged at this time.


-Olof
