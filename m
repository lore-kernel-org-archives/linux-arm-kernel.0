From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 7 Apr 2014 14:10:15 +0530
Subject: [PATCH v7 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <1396519224-18712-4-git-send-email-rahul.sharma@samsung.com>
References: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
 <1396519224-18712-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAK9yfHwWh9sFivsg-P9wT6DXM2J3nYuHqzgfwuo_Go7S-vriVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2014 15:30, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> The patch adds the dts files for xyref5260 board which
> is based on Exynos5260 Evt0 sample.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---

> +/ {
> +       model = "SAMSUNG XYREF5260 EVT0 board based on EXYNOS5260";
> +       compatible = "samsung,xyref5260", "samsung,exynos5260";

"samsung,exynos5260" is OK here for future compatibility (if soc
specific quirk is required).
Please also add "samsung,exynos5" to compatible list.

-- 
With warm regards,
Sachin
