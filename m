From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Aug 2016 12:06:20 +0200
Subject: [PATCH 0/5] clk: samsung: exynos: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <432d1876-d561-6c4e-6808-b7761d128e94@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 08/22/2016 11:48 AM, Chanwoo Choi wrote:
> This patches just fix the checkpatch warnings for exynos5433/3250/5260/5420/4
> series without the behavior changes.
> 
> Chanwoo Choi (5):
>   clk: samsung: exynos5433: Fix the checkpatch warnings
>   clk: samsung: exynos3250: Fix the checkpatch warnings
>   clk: samsung: exynos5260: Fix the checkpatch warnings
>   clk: samsung: exynos5420: Fix the checkpatch warnings
>   clk: samsung: exynos4: Fix the checkpatch warnings
> 
>  drivers/clk/samsung/clk-exynos3250.c | 97 ++++++++++++++++++++----------------
>  drivers/clk/samsung/clk-exynos4.c    | 51 ++++++++++---------
>  drivers/clk/samsung/clk-exynos5260.c |  4 +-
>  drivers/clk/samsung/clk-exynos5420.c | 11 ++--
>  drivers/clk/samsung/clk-exynos5433.c |  6 ++-
>  5 files changed, 88 insertions(+), 81 deletions(-)

Sorry, but I have to NAK this whole series.  It's just an unnecessary
churn and will cause problems when applying real development patches
that are being worked on.

-- 
Thanks,
Sylwester
