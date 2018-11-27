From: vkoul@kernel.org (Vinod Koul)
Date: Tue, 27 Nov 2018 22:09:28 +0530
Subject: [PATCH v2] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module
 device node
In-Reply-To: <20181127151716.31992-1-govinds@codeaurora.org>
References: <20181127151716.31992-1-govinds@codeaurora.org>
Message-ID: <20181127163928.GF3175@vkoul-mobl.Dlink>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-11-18, 20:47, Govind Singh wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on qcs404 soc.
> Optional clock and regulator controls are not yet available in
> upstream, hence add them once available.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  4 ++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi     | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 0767389c68c1..36905524b0ff 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -310,6 +310,10 @@
>  	status = "okay";
>  };
>  
> +&wifi {
> +	status = "okay";
> +};

I am assuming this is common to both evb variants, so:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
