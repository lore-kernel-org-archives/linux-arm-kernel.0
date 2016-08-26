From: oss@buserror.net (Scott Wood)
Date: Fri, 26 Aug 2016 17:38:39 -0500
Subject: [PATCH 08/10] dt-bindings: usb: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-8-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-8-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472251119.13245.11.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 15:57 +0530, Bhaskar Upadhaya wrote:
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
> ?Documentation/devicetree/bindings/usb/fsl-usb.txt | 10 ++++++++++
> ?1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt
> b/Documentation/devicetree/bindings/usb/fsl-usb.txt
> index 4779c02..08ccc6e 100644
> --- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
> @@ -81,3 +81,13 @@ Example dual role USB controller device node for
> MPC5121ADS:
> ?		fsl,invert-drvvbus;
> ?		fsl,invert-pwr-fault;
> ?	};
> +
> +Example dual role USB controller device node for LS1012A:
> +	usb at 8600000 {
> +		compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
> +		reg = <0x0 0x8600000 0x0 0x1000>;
> +		interrupts = <0 139 0x4>;
> +		dr_mode = "host";
> +		phy_type = "ulpi";
> +		fsl,usb-erratum-a005697;
> +	};

What does this change have to do with the incredibly vague changelog of
"Update bindings for LS1012A"?

-Scott
