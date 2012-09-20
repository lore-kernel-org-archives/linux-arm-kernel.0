From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 21:31:19 -0400
Subject: [PATCH 1/3] clk: wm831x: Fix clk_register() error code checking
In-Reply-To: <1348034730-16473-2-git-send-email-sboyd@codeaurora.org>
References: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
 <1348034730-16473-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120920013115.GF17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 11:05:28PM -0700, Stephen Boyd wrote:
> clk_register() returns an ERR_PTR upon failure, not NULL. Fix
> these error paths.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

this is an API change since the driver was sent which the driver didn't
get updatd for.
