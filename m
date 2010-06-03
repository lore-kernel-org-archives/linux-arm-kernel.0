From: eric.miao@canonical.com (Eric Miao)
Date: Thu,  3 Jun 2010 17:43:33 +0800
Subject: [PATCH 0/2] Introduce RUNTIME_PHYS_OFFSET
Message-ID: <1275558215-12743-1-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the Original great work of Uwe Kleine-K?nig, I'm now
able to boot the resulting kernel without PHYS_OFFSET being
defined on my pxa machines.

Uwe,

I've modified a bit into your patch, hopefully to make it look
a bit cleaner. Please help review.
