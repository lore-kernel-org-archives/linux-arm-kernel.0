From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 11 Aug 2017 14:10:08 +0300
Subject: [PATCH 1/3] dts: usb3: Add configure-gfladj property to USB3 nod
In-Reply-To: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
References: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <87r2wi8inj.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

yinbo.zhu at nxp.com writes:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index ffbf3cf..f525297 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -731,6 +731,8 @@
>  			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			configure-gfladj;

this binding isn't documented, nor is it used anywhere.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170811/b86f4b7e/attachment.sig>
