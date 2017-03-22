From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:35:25 -0700
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.12
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <20170322003525.GH5129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 09:58:08AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.12.
> 
> * Conflicts
> 
>   "Add watchdog timer to r7s72100 SoC", which is part of this patch-set,
>   has a minor conflict with "ARM: 8661/1: dts: r7s72100: add l2 cache",
>   which I believe Russell King has in his tree.
> 
>   The resolution is to take both.
> 
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.12
> 
> for you to fetch changes up to d01ff18992218f3a13f45f45a886b3bf8f250f14:
> 
>   ARM: dts: silk: Drop superfluous status update for frequency override (2017-03-13 10:19:35 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.12
> 
> Cleanup:
> * Drop superfluous status update for frequency override on various boards
> * Always use status "okay" to enable devices on porger board
> * Add INTC-SYS clock to device tree of various SoCs
> * Tidyup Audio-DMAC channel for DVC on r8a779[013] SoCs
> * Remove unit-address and reg from integrated cache on various SoCs
> * Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
> * Fix SCIFB0 dmas indentation on r8a774[35] SoCs
> 
> Enhancements:
> * Add watchdog timer to r7s72100 SoC
> * Update sdhi clock bindings on r7s72100 SoC
> 

Merged, thanks.


-Olof
