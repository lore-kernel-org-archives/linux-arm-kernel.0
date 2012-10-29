From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Oct 2012 21:22:22 +0900
Subject: [PATCH v2 1/2] ARM: exynos4: Add devicetree node for TMU driver
In-Reply-To: <1351243746-4173-2-git-send-email-amit.daniel@samsung.com>
References: <1351243746-4173-1-git-send-email-amit.daniel@samsung.com>
 <1351243746-4173-2-git-send-email-amit.daniel@samsung.com>
Message-ID: <508E74FE.7090900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/12 18:29, Amit Daniel Kachhap wrote:
> From: Amit Daniel Kachhap<amit.daniel@samsung.com>
>
> This patch adds necessary source definations needed for TMU driver and
> adds devicetree node for exynos4210.
>
> Signed-off-by: Amit Daniel Kachhap<amit.daniel@samsung.com>
> ---

[...]

> +		.name           = "tmu_apbif",
> +		.enable         = exynos4_clk_ip_perir_ctrl,
> +		.ctrlbit        = (1<<  17),

tab instead of white spaces?

I fixed them when I applied.

[...]

> +#define EXYNOS4_IRQ_TMU_TRIG0		COMBINER_IRQ(2, 4)
> +#define EXYNOS4_IRQ_TMU_TRIG1		COMBINER_IRQ(3, 4)

BTW, where are above definitions used?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
