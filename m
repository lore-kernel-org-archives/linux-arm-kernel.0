From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 22:51:21 +0100
Subject: [PATCH v2 3/4] clk: Provide not locked variant of
 of_clk_get_from_provider()
In-Reply-To: <1377020063-30213-4-git-send-email-s.nawrocki@samsung.com>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130820215121.GG17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 07:34:22PM +0200, Sylwester Nawrocki wrote:
> Add helper functions for the of_clk_providers list locking and
> an unlocked variant of of_clk_get_from_provider().
> These functions are intended to be used in the clkdev to avoid
> race condition in the device tree based clock look up in clk_get().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changes since v1:
>  - moved the function declaractions to a local header.

Yes, this is a much better solution, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
