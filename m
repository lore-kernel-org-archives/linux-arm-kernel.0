From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 14:01:00 +0200
Subject: [PATCH v9 13/19] ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
In-Reply-To: <1473081421-16555-14-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-14-git-send-email-peter.griffin@linaro.org>
Message-ID: <142f56d1-4353-a57c-2dce-59abc3ba4cea@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

On 09/05/2016 03:16 PM, Peter Griffin wrote:
> This patch adds the dt node for the internal audio
> codec IP.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 45cab30..d1258d5 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -873,5 +873,12 @@
>  				<&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
>  				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  		};
> +
> +		sti_sasg_codec: sti-sasg-codec {
> +			compatible = "st,stih407-sas-codec";
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +			st,syscfg = <&syscfg_core>;
> +		};
>  	};
>  };
> 


Applied for STi next

Thanks
