From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jun 2011 10:35:21 +0200
Subject: [PATCH 0/9] Add clkdev support for Samsung platforms
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20110615083521.GF3037@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:08 Thu 09 Jun     , Thomas Abraham wrote:
> This patch series adds clkdev support for all Samsung platforms. clkdev
> support is a prerequisite for adding device tree on Samsung platforms
> and possibly revive framebuffer driver patches for Exynos4 platforms.
> 
> The first of the two patches are for eliminating the explict
> console_initcall from the serial drivers. This is required to prevent
> the clk_get being invoked at time when device registrations have not
> completed.
> 
> This patch series is based on the latest
> git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
> 
> and the patch "[PATCH] Consolidate the clkdev header files".
> 
> It has been tested on the following boards.
> 
> SMDK2416, SMDK2440, SMDK2450, SMDK6410, SMDK6440, SMDK6450,
> SMDKC100, SMDKV210 and SMDKV310.
looks good
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
