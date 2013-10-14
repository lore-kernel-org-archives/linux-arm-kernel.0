From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 18:40:30 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20131014174030.GU25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another thing that my build testing (and use on cubox-i) picked up:

On Thu, Oct 03, 2013 at 03:51:26PM -0300, Fabio Estevam wrote:
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 9e8ae11..65e54b4 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -88,3 +88,7 @@
>  		crtcs = <&ipu1 0>, <&ipu1 1>;
>  	};
>  };
> +
> +&hdmi {
> +	crtcs = <&ipu1 0>, <&ipu1 1>;
> +}

Missing semi-colon.
