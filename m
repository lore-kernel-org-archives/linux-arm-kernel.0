From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 21:40:05 -0400
Subject: [PATCH 3/3] clk: wm831x: Use devm_clk_register() to simplify code
In-Reply-To: <1348034730-16473-4-git-send-email-sboyd@codeaurora.org>
References: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
 <1348034730-16473-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120920014003.GG17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 11:05:30PM -0700, Stephen Boyd wrote:
> Move this driver to use devm_clk_register() to simplify some
> error paths and reduce lines of code.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
