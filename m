From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 5 Nov 2016 17:50:32 +0200
Subject: [PATCH] ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx
 SoCs
In-Reply-To: <1478252753-8231-1-git-send-email-s.nawrocki@samsung.com>
References: <1478252753-8231-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161105155032.GC8183@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 10:45:53AM +0100, Sylwester Nawrocki wrote:
> This patch adds DMA slave map tables for the remaining s3c24xx
> SoC types so the whole platform can be switched to the new API.
> A few devices for which there was no DMA support with current
> code are omitted from the tables.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c24xx/common.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
