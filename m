From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 8 Sep 2015 15:45:04 -0700
Subject: [PATCH 10/11] regulator: qcom-smd: Add support for PMA8084
In-Reply-To: <1441748131-26490-12-git-send-email-agross@codeaurora.org>
References: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
 <1441748131-26490-12-git-send-email-agross@codeaurora.org>
Message-ID: <20150908224504.GA13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 08 Sep 14:35 PDT 2015, Andy Gross wrote:

> This patch adds support and documentation for the PMA8084 regulators
> found on APQ8084 platforms.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |   35 ++++++++
>  drivers/regulator/qcom_smd-regulator.c             |   95 ++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
[..]
> +- vdd_s1:
> +- vdd_s2:
> +- vdd_s3:
> +- vdd_s4:
> +- vdd_s5:
> +- vdd_s6:
> +- vdd_s7:
> +- vdd_s8:
> +- vdd_s9:
> +- vdd_s10:
> +- vdd_s11:
> +- vdd_s12:
> +- vdd_l1_l11:
> +- vdd_l2_l3_l4_l27:
> +- vdd_l5_l7:
> +- vdd_l6_l12_l14_l15_l26:
> +- vdd_l8:
> +- vdd_l9_l10_l13_l20_l23_l24:
> +- vdd_l16_l25:
> +- vdd_l17:
> +- vdd_l18:
> +- vdd_l19:
> +- vdd_l21:
> +- vdd_l22:

-supply

> +	Usage: optional (pma8084 only)
> +	Value type: <phandle>
> +	Definition: reference to regulator supplying the input pin, as
> +		    described in the data sheet
> +

Otherwise it looks good.


Regards,
Bjorn
