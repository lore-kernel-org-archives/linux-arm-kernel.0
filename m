From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 12 Dec 2016 14:39:19 +0100
Subject: [PATCH 1/7] ARM: EXYNOS: Constify list of retention registers
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <10896763.srQzQduvXa@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, December 10, 2016 03:47:32 PM Krzysztof Kozlowski wrote:
> The list of retention registers (release_ret_regs field of struct
> exynos_pm_data and arrays with values) are not modified and can be made
> const to improve the const safeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

for patches #1-7

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
