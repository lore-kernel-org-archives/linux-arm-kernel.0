From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 15 May 2012 12:49:49 -0500
Subject: [PATCH 1/2] ARM: dts: add device tree source for imx6dl
In-Reply-To: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
References: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120515124949.546ba4fc3b624a4777e320af@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012 20:13:47 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> +			snvs at 020cc000 {
> +				reg = <0x020cc000 0x4000>;
> +				interrupts = <0 19 0x04 0 20 0x04>;
> +			};
> +

this conflicts with the existing binding documented in
Documentation/devicetree/bindings/crypto/fsl-sec4.txt.

> +			caam at 02100000 {
> +				reg = <0x02100000 0x40000>;
> +				interrupts = <0 105 0x04 0 106 0x04>;
> +			};
> +

same here.

Kim
