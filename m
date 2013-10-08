From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 11:34:10 -0700
Subject: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
In-Reply-To: <1377598305-15539-1-git-send-email-rnayak@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Message-ID: <20131008183410.GJ8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130827 03:19]:
> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
> use drivers/misc/sram.c driver instead of the omap internal
> implementation for SRAM handling.

Sounds like this series has some dependencies that we need
to clear, so marking this thread as read and assuming a new
series will be posted.

Regards,

Tony
