From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Apr 2015 15:54:06 +0800
Subject: [PATCH v2 5/7] clk: zx: add clock support to zx296702
In-Reply-To: <1427464356-20112-6-git-send-email-jun.nie@linaro.org>
References: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
 <1427464356-20112-6-git-send-email-jun.nie@linaro.org>
Message-ID: <20150413075404.GA29331@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 09:52:34PM +0800, Jun Nie wrote:
> It adds a clock driver for zx296702 SoC to register the clock tree to
> Common Clock Framework.  All the clocks of bus topology and some the
> peripheral clocks are ready with this commit. Some missing leaf clocks
> for peripherals will be added later when needed.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
