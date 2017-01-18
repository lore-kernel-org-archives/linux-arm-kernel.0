From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 18 Jan 2017 22:42:01 +0900
Subject: [PATCH 2/3] pinctrl: dt-bindings: samsung: Add Exynos7 specific
 pinctrl macro definitions
In-Reply-To: <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170118054002epcas5p3b08e2f419976e17a3c584d64776810fd@epcas5p3.samsung.com>
 <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <1484718141-28785-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAGOxZ50V0-3PhFVYezm57ZJFJUxG3XvPM247Tz3Or3Hvj1qhkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 18, 2017 at 2:42 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Exynos7 SoC pinctrl configurations are similar to existing Exynos4/5 except
> for FSYS1 pinctrl drive strengths. So adding Exynos7 specific FSYS1 blocks
> pinctrl driver strength related macros which will be used in Exynos7
> DTSi files.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  include/dt-bindings/pinctrl/samsung.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
> index 6276eb7..3f1d583 100644
> --- a/include/dt-bindings/pinctrl/samsung.h
> +++ b/include/dt-bindings/pinctrl/samsung.h
> @@ -54,4 +54,12 @@
>  #define EXYNOS_PIN_FUNC_6              6
>  #define EXYNOS_PIN_FUNC_F              0xf
>
> +/* Drive strengths for Exynos7 FSYS1 block */
> +#define EXYNOS7_FSYS1_PIN_DRV_LV1      0
> +#define EXYNOS7_FSYS1_PIN_DRV_LV2      4
> +#define EXYNOS7_FSYS1_PIN_DRV_LV3      2
> +#define EXYNOS7_FSYS1_PIN_DRV_LV4      6
> +#define EXYNOS7_FSYS1_PIN_DRV_LV5      1
> +#define EXYNOS7_FSYS1_PIN_DRV_LV6      5
> +
>  #endif /* __DT_BINDINGS_PINCTRL_SAMSUNG_H__ */
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
