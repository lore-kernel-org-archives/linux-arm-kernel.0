From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:34:49 -0700
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.12
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <20170322003449.GG5129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 09:57:30AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC DT updates for v4.12.
> 
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.12
> 
> for you to fetch changes up to 3cbe33367d4fd480a92fbc131a96fa925be9e95d:
> 
>   arm64: dts: r8a7796: salvator-x: Drop superfluous status update for frequency override (2017-03-13 10:21:16 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.12
> 
> Cleanup:
> * Drop superfluous status update for frequency override from all
>   r8a779[56] boards
> * Tidyup Audio-DMAC channel for DVC for r8a7795 SoC
> * Remove unit-address and reg from integrated cache on r8a779[56] SoCs
> 
> Enhancements:
> * Add all Cortex-A53 and Cortex-A57 CPU cores to r8a7796 SoC
> * Add Cortex-A53 CPU cores to r8a7795 SoC
> * Update memory node to 4 GiB map on h3ulcb board
> * Upgrade to PSCI v1.0 to support Suspend-to-RAM on r8a779[56] SoCs
> * Add SCIF1 (DEBUG1) to r8a7796/salvator-x board
> * Add all SCIF and HSCIF nodes with DMA enabled to r8a7796 SoC
> * Set drive-strength for ravb pins for r8a7795/salvator-x board
> * Enable gigabit ethernet on r8a779[56]/salvator-x boards
> * Enable I2C for DVFS device r8a779[56]/salvator-x boards

Merged into next/dt64. Thanks!

-Olof
