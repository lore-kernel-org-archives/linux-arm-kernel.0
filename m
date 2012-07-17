From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 17 Jul 2012 12:11:00 +0200
Subject: [PATCH 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Message-ID: <20120717101100.GI4213@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 08:55:58PM -0500, Omar Ramirez Luna wrote:
> Omar Ramirez Luna (6):
>   ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
>   ARM: OMAP3: hwmod data: add mmu data for iva and isp
>   ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
>   ARM: OMAP3/4: iommu: migrate to hwmod framework
>   ARM: OMAP2+: iommu: add reset handling
>   ARM: OMAP3/4: iommu: adapt to runtime pm

What happens with this patch-set. Comments anyone? Ohad?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
