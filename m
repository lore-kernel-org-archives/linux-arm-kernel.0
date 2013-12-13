From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Dec 2013 15:01:11 +0800
Subject: [PATCH 7/7] ARM: dts: imx6q-sabrelite: Enable PCI express
In-Reply-To: <1386757818-5154-7-git-send-email-marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
 <1386757818-5154-7-git-send-email-marex@denx.de>
Message-ID: <20131213070109.GQ18380@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 11:30:18AM +0100, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Harro Haan <hrhaan@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index fca8f220..f570ad5 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -190,6 +190,10 @@
>  	};
>  };
>  
> +&pcie {
> +	status = "okay";
> +};
> +
>  &sata {
>  	status = "okay";
>  };
> -- 
> 1.8.4.3
> 
