From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 22:28:51 +0000
Subject: [PATCH v3 06/24] ARM: dts: imx6-sabrelite: add OV5642 and OV5640
 camera sensors
In-Reply-To: <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170130222851.GA27898@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:24PM -0800, Steve Longerbeam wrote:
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 66d10d8..9e2d26d 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -52,3 +52,9 @@
>  &sata {
>  	status = "okay";
>  };
> +
> +&ipu1_csi1_from_mipi_vc1 {
> +	data-lanes = <0 1>;
> +	clock-lanes = <2>;
> +};
> +
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index 795b5a5..bca9fed 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
...
> +/* Incoming port from sensor */
> +&mipi_csi_from_mipi_sensor {
> +        remote-endpoint = <&ov5640_to_mipi_csi>;
> +        data-lanes = <0 1>;
> +        clock-lanes = <2>;
> +};
> +

Applying: ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera sensors
.git/rebase-apply/patch:33: new blank line at EOF.
+
.git/rebase-apply/patch:201: new blank line at EOF.
+
warning: 2 lines add whitespace errors.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
