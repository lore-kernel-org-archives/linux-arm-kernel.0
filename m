From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 17 Oct 2014 09:37:24 +0000
Subject: [PATCH v4] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <367D14D2-228C-4BC8-9D01-F45EC6C9B005@codeaurora.org>
References: <1413428973-29982-1-git-send-email-Li.Xiubo@freescale.com>
 <367D14D2-228C-4BC8-9D01-F45EC6C9B005@codeaurora.org>
Message-ID: <30c0e84a022340bcae3c8f5086b4e4b4@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > .../devicetree/bindings/clock/ls1021a-clock.txt    |  27 +++
> > arch/arm/mach-imx/Makefile                         |   2 +
> > arch/arm/mach-imx/clk-ls1021a.c                    | 191
> +++++++++++++++++++++
> > arch/arm/mach-imx/clk.h                            |   8 +
> > include/dt-bindings/clock/ls1021a-clock.h          |  55 ++++++
> 
> Why is clock support for a new platform in mach-imx instead of drivers/clk ?
> 

@Shawn,

Has any suggestions about move this to drivers/clk/ ?

Thanks,

BRs
Xiubo


> > 5 files changed, 283 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/clock/ls1021a-clock.txt
> > create mode 100644 arch/arm/mach-imx/clk-ls1021a.c
> > create mode 100644 include/dt-bindings/clock/ls1021a-clock.h
> 
> - k
> 
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
