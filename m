From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 22 Mar 2017 20:00:00 +0200
Subject: [PATCH 1/2] pinctrl: samsung: Add missing part for
 PINCFG_TYPE_DRV of Exynos5433
In-Reply-To: <1490169812-25225-2-git-send-email-cw00.choi@samsung.com>
References: <1490169812-25225-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170322080335epcas5p2c169c15e1b9db200aee9ca83c71699f6@epcas5p2.samsung.com>
 <1490169812-25225-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170322180000.z2u6syrxhaa752ha@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:03:31PM +0900, Chanwoo Choi wrote:
> The commit 1259feddd0f8("pinctrl: samsung: Fix the width of
> PINCFG_TYPE_DRV bitfields for Exynos5433") already fixed
> the different width of PINCFG_TYPE_DRV from previous Exynos SoC.
> 
> But, when merged the multiple patches, the missing parts occurred.
> So, this patch adds the missing part using the EXYNOS5433_PIN_BANK_* macro.
> 
> Fixes: 7f36f5d11cda ("Merge tag 'v4.10-rc6' into devel")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 80 ++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
> 

Thanks, applied. I also verified that this would indeed be a proper
merge conflict resolution.

Best regards,
Krzysztof
