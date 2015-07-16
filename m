From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 16 Jul 2015 00:07:28 +0000 (UTC)
Subject: [PATCH 1/3] ARM: OMAP2+: hwmod: add support for lock and unlock
 hooks
In-Reply-To: <1433928386-24891-2-git-send-email-lokeshvutla@ti.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <1433928386-24891-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1507160007190.32764@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Jun 2015, Lokesh Vutla wrote:

> Some IP blocks like RTC, needs an additional setting for writing to its
> registers. This is to prevent any spurious writes from changing the
> register values.
> 
> This patch adds optional lock and unlock function pointers to
> the IP block's hwmod data. These unlock and lock function pointers
> are called by hwmod code before and after writing sysconfig registers.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v4.3.

- Paul
