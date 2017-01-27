From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 27 Jan 2017 13:25:42 +0100
Subject: [PATCH 2/3] pinctrl: dt-bindings: samsung: Add Exynos7 specific
 pinctrl macro definitions
In-Reply-To: <20170118141935.eu7wmki7jnjdarkw@kozik-lap>
References: <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118054002epcas5p3b08e2f419976e17a3c584d64776810fd@epcas5p3.samsung.com>
 <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
 <20170118141935.eu7wmki7jnjdarkw@kozik-lap>
Message-ID: <7a0d543f-37e8-98e9-15b4-7d3f808f8516@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 03:19 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 18, 2017 at 11:12:20AM +0530, Pankaj Dubey wrote:
>> Exynos7 SoC pinctrl configurations are similar to existing Exynos4/5 except
>> for FSYS1 pinctrl drive strengths. So adding Exynos7 specific FSYS1 blocks
>> pinctrl driver strength related macros which will be used in Exynos7
>> DTSi files.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  include/dt-bindings/pinctrl/samsung.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I will need this header, so Sylwester if it is okay with you, could you
> provide a tag with it (or ack it)?

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I don't have pinctrl/samsung git tree, Linus applies patches directly.

-- 
Regards,
Sylwester

> diff --git a/include/dt-bindings/pinctrl/samsung.h
b/include/dt-bindings/pinctrl/samsung.h
> index 6276eb7..3f1d583 100644
> --- a/include/dt-bindings/pinctrl/samsung.h
> +++ b/include/dt-bindings/pinctrl/samsung.h
> @@ -54,4 +54,12 @@
>  #define EXYNOS_PIN_FUNC_6		6
>  #define EXYNOS_PIN_FUNC_F		0xf
>
> +/* Drive strengths for Exynos7 FSYS1 block */
> +#define EXYNOS7_FSYS1_PIN_DRV_LV1	0
> +#define EXYNOS7_FSYS1_PIN_DRV_LV2	4
> +#define EXYNOS7_FSYS1_PIN_DRV_LV3	2
> +#define EXYNOS7_FSYS1_PIN_DRV_LV4	6
> +#define EXYNOS7_FSYS1_PIN_DRV_LV5	1
> +#define EXYNOS7_FSYS1_PIN_DRV_LV6	5
> +
>  #endif /* __DT_BINDINGS_PINCTRL_SAMSUNG_H__ */
> -- 2.7.4
