From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 19 Aug 2016 16:58:07 +0000
Subject: [PATCH] ARM: davinci_all_defconfig: Enable some UBI modules
In-Reply-To: <20160819164736.10199-1-kbeldan@baylibre.com>
References: <20160819164736.10199-1-kbeldan@baylibre.com>
Message-ID: <20160819165807.GC14474@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 04:47:35PM +0000, Karl Beldan wrote:
> This enables UBI+UBIFS to handle the NAND MTDs, including the useful
> MTD_UBI_BLOCK.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 

I wanted to send this one after 
"[PATCH v2] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
matching" but wildcards failed me. I didn't include it in a series as
said commit is already a dependency of already applied changes.

Rgds, 
Karl
