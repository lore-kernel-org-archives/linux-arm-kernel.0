From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 13:34:26 -0600
Subject: [PATCH v4 2/4] dt-bindings: qcom: Add SDM845 bindings
In-Reply-To: <20180216060503.22006-3-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-3-rnayak@codeaurora.org>
Message-ID: <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 11:35:01AM +0530, Rajendra Nayak wrote:
> Add a SoC string 'sdm845' for the qualcomm SDM845 SoC
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> index 0ed4d39d7fe1..ee532e705d6c 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.txt
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
>  	msm8996
>  	mdm9615
>  	ipq8074
> +	sdm845

These should really be the full string with 'qcom,', but you don't have 
to fix that now.

Reviewed-by: Rob Herring <robh@kernel.org>
