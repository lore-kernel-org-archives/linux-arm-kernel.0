From: B48286@freescale.com (Hou Zhiqiang)
Date: Wed, 14 Oct 2015 12:02:07 +0000
Subject: [PATCH V3 0/6] Add LS1043A SoC support 
In-Reply-To: <BN3PR0301MB1249C8F2305C3ED1723055B6843F0@BN3PR0301MB1249.namprd03.prod.outlook.com>
References: <BN3PR0301MB1249C8F2305C3ED1723055B6843F0@BN3PR0301MB1249.namprd03.prod.outlook.com>
Message-ID: <CY1PR0301MB0780936EF3D2E04A1F7AF5718B3F0@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Sorry for my late response due to Chinese National Day holidays.

> From: Zhiqiang Hou [mailto:B48286 at freescale.com]
> Sent: Wednesday, October 14, 2015 7:35 PM
> To: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; linux-i2c at vger.kernel.org; linux-
> watchdog at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> clk at vger.kernel.org; mark.rutland at arm.com
> Cc: Hu Mingkai-B21284; Xie Shaohui-B21989; Wood Scott-B07421; Sharma
> Bhupesh-B45370; Li Yang-Leo-R58472; wsa at the-dreams.de; wim at iguana.be;
> corbet at lwn.net; mturquette at baylibre.com; sboyd at codeaurora.org; Song
> Wenbin-B53747
> Subject: [PATCH V3 0/6] Add LS1043A SoC support
> 
> This patchest adds support for Freescale's LS1043A SoC which is based on
> ARMv8 architecture.
> 
> Some pending patches are depended on:
> 1. The LS1043A is belong to Freescale's ARMv8 Layerscape SoC family, so
> depends on the updating ARCH kconfig patch.
> https://patchwork.kernel.org/patch/7120101/
> 
> 2. The LS1043A use the new clockgen binding updated by Scott Wood,
> depends on the patchset:
> https://patchwork.kernel.org/patch/7225421/
> https://patchwork.kernel.org/patch/7225461/
> https://patchwork.kernel.org/patch/7225431/
> https://patchwork.kernel.org/patch/7225441/
> https://patchwork.kernel.org/patch/7225451/
> 
> [PATCH V3 1/6] i2c: Add i2c support to Freescale Layerscape platforms
> [PATCH V3 2/6] watchdog: Add support for Freescale Layerscape [PATCH V3
> 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board [PATCH V3 4/6]
> arm64/ls1043a: add DTS for Freescale LS1043A SoC [PATCH V3 5/6] clk:
> qoriq: Add ls1043a support.
> [PATCH V3 6/6] dts/ls1043a: add LS1043ARDB board support

Thanks,
Zhiqiang
