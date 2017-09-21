From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:40:28 +0100
Subject: [v5 00/12] soc/fsl/qbman: Enable QBMan on ARM Platforms
In-Reply-To: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921144028.nv2f54w55quyabje@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:35PM -0400, Roy Pledge wrote:
> Madalin Bucur (4):
>   soc/fsl/qbman: Drop set/clear_bits usage
>   soc/fsl/qbman: add QMAN_REV32
>   soc/fsl/qbman: different register offsets on ARM
>   soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM
> 
> Roy Pledge (5):
>   soc/fsl/qbman: Add common routine for QBMan private allocations
>   soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
>   soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
>   dt-bindings: soc/fsl: Update reserved memory binding for QBMan
>   soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
> 
> Valentin Rothberg (1):
>   soc/fsl/qbman: Fix ARM32 typo

I reviewed the patches specific to the arm qbman buffer mappings, they
look fine to me. The DT bindings would need acks from the devicetree
maintainers. The rest of the patches are qbman-specific definitions
which I haven't checked for correctness (I guess they are fine).

How do you plan to upstream these patches? They would probably go in via
arm-soc.

-- 
Catalin
