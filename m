From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 16 Aug 2017 09:41:22 +0100
Subject: [PATCH v2] arm64: dts: hi6220: add acpu_sctrl
In-Reply-To: <1502868395-11481-1-git-send-email-zhangfei.gao@linaro.org>
References: <1502868395-11481-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <59940532.7010700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei,

On 2017/8/16 8:26, Zhangfei Gao wrote:
> Add acpu_sctrl clock node
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> ---
> Update name to acpu_sctrl at f6504000
> 
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index eacbe0d..f8012d5 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -262,6 +262,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		acpu_sctrl: acpu_sctrl at f6504000 {
> +			compatible = "hisilicon,hi6220-acpu-sctrl", "syscon";
> +			reg = <0x0 0xf6504000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		medianoc_ade: medianoc_ade at f4520000 {
>  			compatible = "syscon";
>  			reg = <0x0 0xf4520000 0x0 0x4000>;
> 

Thanks!
Dropped the v1 and applied v2 to the hisilicon dt tree.

Best Regards,
Wei
