From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jul 2018 22:19:12 +0200
Subject: [PATCH v5 1/5] clk: actions: Fix the missing REGMAP_MMIO
 dependency
In-Reply-To: <20180715200151.10416-2-sravanhome@gmail.com>
References: <20180715200151.10416-1-sravanhome@gmail.com>
 <20180715200151.10416-2-sravanhome@gmail.com>
Message-ID: <4255c9c7-fffb-5b35-dbb7-ec91c6424c34@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.07.2018 um 22:01 schrieb Saravanan Sekar:
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Still no Fixes: header. Please read SubmittingPatches.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
