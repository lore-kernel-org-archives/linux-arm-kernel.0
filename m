From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 12 Apr 2015 01:12:26 +0300
Subject: [PATCH V3 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <1428736145-18361-6-git-send-email-sricharan@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
 <1428736145-18361-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <55299C4A.3020905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/11/2015 10:09 AM, Sricharan R wrote:

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>   arch/arm/boot/dts/qcom-msm8974.dtsi | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index e265ec1..2c26151 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
[...]
> @@ -247,5 +247,15 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   		};
> +
> +		blsp2_dma: dma at f9944000 {

    The ePAPR standard says that the node name should be "dma-controller", not 
just "dma".

[...]

WBR, Sergei
