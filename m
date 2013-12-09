From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 14:35:28 +0100
Subject: [PATCH] clk: samsung: exynos4: Correct SRC_MFC register
In-Reply-To: <1385097668-24620-1-git-send-email-sw0312.kim@samsung.com>
References: <1385097668-24620-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <4009792.HvWcr5GnEc@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Seung-Woo,

On Friday 22 of November 2013 14:21:08 Seung-Woo Kim wrote:
> The SRC_MFC register was incorrect. This patch corrects it.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Good catch.

Acked-by: Tomasz Figa <t.figa@samsung.com>

I guess this could go as a fix for current rc, through clk-fixes.
Mike, what do you think?

Best regards,
Tomasz
