From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 21:57:45 +0800
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110929135744.GI19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2011 at 08:26:09PM -0700, Barry Song wrote:
> we save the l2x0 registers at the first initialization, and platform codes
> can get them to restore l2x0 status after wakeup.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Barry,

You may want to fix those checkpatch error and warnings in v3.

total: 1 errors, 15 warnings, 181 lines checked

-- 
Regards,
Shawn
