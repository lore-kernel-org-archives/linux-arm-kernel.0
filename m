From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 15:08:22 -0800
Subject: [RESEND PATCH v7 4/5] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1422133973-16460-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1422133973-16460-1-git-send-email-bhupesh.sharma@freescale.com>
 <1422133973-16460-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <20150127230822.GF11789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 02:42:52AM +0530, Bhupesh Sharma wrote:
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
> In addition, this patch adds build support for FSL's LS2085A
> simulator model in arm64 dts Makefile.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Arnab Basu <arnab_basu@rocketmail.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>  arch/arm64/boot/dts/Makefile                       |    1 +
>  arch/arm64/boot/dts/{ => freescale}/Makefile       |    4 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts |   65 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  163 ++++++++++++++++++++
>  4 files changed, 230 insertions(+), 3 deletions(-)
>  copy arch/arm64/boot/dts/{ => freescale}/Makefile (54%)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi


Applied, thanks.


-Olof
