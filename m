From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 8 Apr 2017 14:42:32 +0800
Subject: [PATCH 1/2] arm64: dts: add drive-strength levels of pin for
 Hi3660 SoC
In-Reply-To: <20170330064803.18648-1-hw.wangxiaoyin@hisilicon.com>
References: <20170330064803.18648-1-hw.wangxiaoyin@hisilicon.com>
Message-ID: <58E88658.20805@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiaoyin,

On 2017/3/30 14:48, Wang Xiaoyin wrote:
> Add drive-strength levels of pin for Hi3660 Soc.
>
> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

Thanks!
Applied both to the hisilicon arm64 dt tree.

Best Regards,
Wei
> ---
>   include/dt-bindings/pinctrl/hisi.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
> index 38f1ea879ea1..0359bfdc9119 100644
> --- a/include/dt-bindings/pinctrl/hisi.h
> +++ b/include/dt-bindings/pinctrl/hisi.h
> @@ -56,4 +56,19 @@
>   #define DRIVE4_08MA	(4 << 4)
>   #define DRIVE4_10MA	(6 << 4)
>   
> +/* drive strength definition for hi3660 */
> +#define DRIVE6_MASK	(15 << 4)
> +#define DRIVE6_04MA	(0 << 4)
> +#define DRIVE6_12MA	(4 << 4)
> +#define DRIVE6_19MA	(8 << 4)
> +#define DRIVE6_27MA	(10 << 4)
> +#define DRIVE6_32MA	(15 << 4)
> +#define DRIVE7_02MA	(0 << 4)
> +#define DRIVE7_04MA	(1 << 4)
> +#define DRIVE7_06MA	(2 << 4)
> +#define DRIVE7_08MA	(3 << 4)
> +#define DRIVE7_10MA	(4 << 4)
> +#define DRIVE7_12MA	(5 << 4)
> +#define DRIVE7_14MA	(6 << 4)
> +#define DRIVE7_16MA	(7 << 4)
>   #endif
