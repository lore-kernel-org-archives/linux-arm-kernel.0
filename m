From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Sep 2010 11:04:43 +0100
Subject: [PATCH v2] regulators: add support max8952 regulator
In-Reply-To: <1283844202-4158-1-git-send-email-kgene.kim@samsung.com>
References: <1283844202-4158-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100907100442.GD7886@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 07, 2010 at 04:23:22PM +0900, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> The operation of max8952 is almost similar to max8649 except
> the output voltage range. This patch adds support the max8952
> regulator using current max8649 implementation.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

This is OK but it should also include removal of the separate max8952
driver since the functionality is now merged into this driver.  With
that

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
