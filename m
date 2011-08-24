From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 20:13:56 +0900
Subject: [PATCH 4/4] ARM: EXYNOS4: Use samsung_rev() to distinguish silicon
	revision
In-Reply-To: <1313816759-14564-5-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
	<1313816759-14564-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <06f401cc624e$eaa67390$bff35ab0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch uses samsung_rev() to support variable silicon revision of
> EXYNOS4210 so that can support for EXYNOS4210 REV0, REV1.0 and REV1.1.
> 
> Note: Need to change timer setting on REV0.
> 
> Acked-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---

(snip)

> +#define EXYNOS4210_REV_1_0	(0x2)
> +#define EXYNOS4210_REV_1_1	(0x3)

Should be following...

+#define EXYNOS4210_REV_1_0	(0x10)
+#define EXYNOS4210_REV_1_1	(0x11)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
