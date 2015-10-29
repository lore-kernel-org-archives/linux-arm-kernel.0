From: leoli@freescale.com (Li Yang)
Date: Thu, 29 Oct 2015 15:33:06 -0500
Subject: [PATCH V6 6/6] dts/ls1043a: add LS1043ARDB board support
In-Reply-To: <1445587282-29529-6-git-send-email-B48286@freescale.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
 <1445587282-29529-6-git-send-email-B48286@freescale.com>
Message-ID: <CADRPPNRKXDAQHijZtJOYo9wMPaciJnoQYhR1UWRgFGUXY=iAMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 3:01 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
> V6: V5 V4 V3
>  - No change.
>
> V2:
>  - Remove the useless compatible "simple-bus" from cpld node.
>
>  arch/arm64/boot/dts/freescale/Makefile            |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 116 ++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 57b41c7..33b1e57 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-rdb.dtb fsl-ls2080a-simu.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb fsl-ls2080a-rdb.dtb fsl-ls2080a-simu.dtb fsl-ls1043a-rdb.dtb

I tried to apply the patch, but it can not be applied due to the
change from a depending ls2080 patch.  I will help to respin this
patch and resend the three device tree related patches.

Regards,
Leo
