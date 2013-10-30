From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 00:19:25 +0000
Subject: [PATCH v7 4/5] clk: Add common __clk_get(), __clk_put()
 implementations
In-Reply-To: <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <1383076268-8984-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20131030001924.GX16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 08:51:07PM +0100, Sylwester Nawrocki wrote:
> This patch adds common __clk_get(), __clk_put() clkdev helpers that
> replace their platform specific counterparts when the common clock
> API is used.
> 
> The owner module pointer field is added to struct clk so a reference
> to the clock supplier module can be taken by the clock consumers.
> 
> The owner module is assigned while the clock is being registered,
> in functions _clk_register() and __clk_register().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
