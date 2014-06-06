From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 06 Jun 2014 15:12:48 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDY6IGFkZCBtaXNzaW5nIGNvbXBh?=
 =?UTF-8?B?dGlibGUgYW5kIGNsb2NrIHByb3BlcnRpZXMgZm9yIGtwcA==?=
In-Reply-To: <1402052579-22803-1-git-send-email-LW@KARO-electronics.de>
References: <1402052579-22803-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1402053168.820883127@f387.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri,  6 Jun 2014 13:02:59 +0200 ?? Lothar Wa?mann <LW@KARO-electronics.de>:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ce05991..3266d01 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -466,8 +466,10 @@
>  			};
>  
>  			kpp: kpp at 020b8000 {
> +				compatible = "fsl,imx6q-kpp", "fsl,imx21-kpp";
>  				reg = <0x020b8000 0x4000>;
>  				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks 62>; /* IPG clock */

Comment is excess. I hope Shawn can strip it while applying.

---
