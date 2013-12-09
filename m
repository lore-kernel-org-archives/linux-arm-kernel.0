From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 9 Dec 2013 10:21:55 +0530
Subject: [PATCH 2/7] pinctrl: exynos: add exynos5260 SoC specific data
In-Reply-To: <1386345391-23482-3-git-send-email-rahul.sharma@samsung.com>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAK9yfHxJP8gUpvngcT-iu3j0+=J60X3DojRe9OXb3uek+VVqaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul, Young-Gun,

On 6 December 2013 21:26, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
>
> Add Samsung Exynos5260 SoC specific data to enable pinctrl
> support for all platforms based on EXYNOS5260.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>

Author's (Young-Gun Jang) signed-off by is missing here.

[snip]

> +
> +/* pin banks of exynos5260 pin-controller 2 */
> +static struct samsung_pin_bank exynos5260_pin_banks2[] = {
> +       EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
> +       EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
> +};
> +
> +/*
> + * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5420 SoC includes

s/5420/5260 ?

-- 
With warm regards,
Sachin
