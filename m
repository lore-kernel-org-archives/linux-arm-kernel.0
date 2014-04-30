From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 30 Apr 2014 11:57:02 -0700
Subject: [PATCH] clk: qcom: Remove accidental merged reject file
In-Reply-To: <1398881711-5566-1-git-send-email-galak@codeaurora.org>
References: <1398881711-5566-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140430185702.5718.43337@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kumar Gala (2014-04-30 11:15:11)
> Looks like commit cff558c79f572530bdbbb9b847134094008afcef accidentally
> added in a merge reject file, so remove it.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

I fixup'd this into "clk: qcom: Add basic support for APQ8064 global
clock controller clocks".

Thanks for the fix,
Mike

> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej | 10 ----------
>  1 file changed, 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej b/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej
> deleted file mode 100644
> index 2e84dbe..0000000
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt.rej
> +++ /dev/null
> @@ -1,10 +0,0 @@
> ---- Documentation/devicetree/bindings/clock/qcom,gcc.txt
> -+++ Documentation/devicetree/bindings/clock/qcom,gcc.txt
> -@@ -4,6 +4,7 @@
> - Required properties :
> - - compatible : shall contain only one of the following:
> - 
> -+                      "qcom,gcc-apq8064"
> -                       "qcom,gcc-ipq8064"
> -                       "qcom,gcc-msm8660"
> -                       "qcom,gcc-msm8960"
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
