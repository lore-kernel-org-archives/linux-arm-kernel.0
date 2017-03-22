From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 22 Mar 2017 20:11:27 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Remove unused pin-bank macro
In-Reply-To: <1490169812-25225-3-git-send-email-cw00.choi@samsung.com>
References: <1490169812-25225-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170322080335epcas5p2f514974da14bd739d712cf1ab1a4cc0c@epcas5p2.samsung.com>
 <1490169812-25225-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170322181127.aolaevubauaolb3g@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:03:32PM +0900, Chanwoo Choi wrote:
> After merged commit 1259feddd0f8 ("pinctrl: samsung: Fix the width
> of PINCFG_TYPE_DRV bitfields for Exynos5433"), EXYNOS_PIN_BANK_EINTW
> was replaced by EXYNOS5433_PIN_BANK_EINTW_EXT. This patch removes
> the unused pin-bank macro (EXYNOS_PIN_BANK_EINTW).
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 

Thanks, applied and squashed with previous one (it is logically the same
change).

Best regards,
Krzysztof
