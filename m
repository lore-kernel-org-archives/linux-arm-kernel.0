From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 15 Aug 2014 08:29:53 -0500
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <0E51617C-0C5C-4A9A-AB90-394FB7FBE55D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2014, at 4:49 AM, Bhupesh Sharma <bhupesh.sharma@freescale.com> wrote:

> This patch adds the device tree support for FSL LS2085A SoC
> based on ARMv8 architecture.
> 
> Following levels of DTSI/DTS files have been created for the
> LS2085A SoC family:
> 
> - fsl-ls2085a.dtsi:
> DTS-Include file for FSL LS2085A SoC.
> 
> - fsl-ls2085a-simu.dts:
> DTS file for FSL LS2085a software simulator model.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   29 ++++++

Hmm, outside of something like qemu, we don?t normally have simulation model dts/support in the kernel.

> arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  145 ++++++++++++++++++++++++++++++
> 2 files changed, 174 insertions(+)
> create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
