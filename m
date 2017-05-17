From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 17 May 2017 13:19:56 +0300
Subject: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
In-Reply-To: <20170516061720.1755-1-jszhang@marvell.com>
References: <20170516061720.1755-1-jszhang@marvell.com>
Message-ID: <9a1fdf1f-cf44-5aa5-f2a3-5e5a0a05777a@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 09:17, Jisheng Zhang wrote:
> Currently, the xenon_clean_phy() is only used for freeing phy_params.
> The phy_params is allocated by devm_kzalloc(), there's no need to free
> is explicitly.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
