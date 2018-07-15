From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jul 2018 23:39:41 +0200
Subject: [PATCH v6 1/5] clk: actions: Add missing REGMAP_MMIO dependency
In-Reply-To: <20180715203524.11948-2-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-2-sravanhome@gmail.com>
Message-ID: <9b580b0c-3cbe-a608-fb21-e8950e259c2f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.07.2018 um 22:35 schrieb Saravanan Sekar:
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> 
> Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
