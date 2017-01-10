From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 10:17:19 +0800
Subject: [PATCH v4] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1483437451-20971-1-git-send-email-harninder.rai@nxp.com>
References: <1483437451-20971-1-git-send-email-harninder.rai@nxp.com>
Message-ID: <20170110021717.GR20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 03:27:31PM +0530, Harninder Rai wrote:
> LS1012A features an advanced 64-bit ARM v8 CortexA53 processor
> with 32 KB of parity protected L1-I cache, 32 KB of ECC protected
> L1-D cache, as well as 256 KB of ECC protected L2 cache.
> 
> Features summary
>  One 64-bit ARM-v8 Cortex-A53 core with the following capabilities
>   - Arranged as a cluster of one core supporting a 256 KB L2 cache with ECC
>     protection
>   - Speed up to 800 MHz
>   - Parity-protected 32 KB L1 instruction cache and 32 KB L1 data cache
>   - Neon SIMD engine
>   - ARM v8 cryptography extensions
>  One 16-bit DDR3L SDRAM memory controller
>  ARM core-link CCI-400 cache coherent interconnect
>  Cryptography acceleration (SEC)
>  One Configurable x3 SerDes
>  One PCI Express Gen2 controller, supporting x1 operation
>  One serial ATA (SATA Gen 3.0) controller
>  One USB 3.0/2.0 controller with integrated PHY
> 
>  Following levels of DTSI/DTS files have been created for the LS1012A
>    SoC family:
> 
>            - fsl-ls1012a.dtsi:
>                    DTS-Include file for FSL LS1012A SoC.
> 
>            - fsl-ls1012a-frdm.dts:
>                    DTS file for FSL LS1012A FRDM board.
> 
>            - fsl-ls1012a-qds.dts:
>                    DTS file for FSL LS1012A QDS board.
> 
>            - fsl-ls1012a-rdb.dts:
>                     DTS file for FSL LS1012A RDB board.
> 
> Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>

I changed subject a bit as below and applied patch.

 arm64: dts: Add support for FSL's LS1012A SoC

Shawn
