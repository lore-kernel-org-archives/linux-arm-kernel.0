From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Apr 2018 08:18:44 -0500
Subject: [PATCH v4 04/14] clk: qcom: Add DT bindings for CPU clock driver
 for msm8996
In-Reply-To: <1522358807-10413-5-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-5-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180405131844.sfhta7qjdsmxpa4d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 12:26:37AM +0300, Ilia Lin wrote:

Needs a commit message.

> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>

Add acks/reviewed-bys when posting new versions.

> ---
>  Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> new file mode 100644
> index 0000000..8458783
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
> @@ -0,0 +1,17 @@
> +Qualcomm CPUSS clock controller for Kryo CPUs
> +----------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +
> +			"qcom,msm8996-apcc"
> +
> +- reg : shall contain base register location and length
> +- #clock-cells : shall contain 1
> +
> +Example:
> +	kryocc: clock-controller at 6400000 {
> +		compatible = "qcom,msm8996-apcc";
> +		reg = <0x6400000 0x90000>;
> +		#clock-cells = <1>;
> +	};
> -- 
> 1.9.1
> 
