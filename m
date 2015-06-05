From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Jun 2015 14:53:19 +0200
Subject: [PATCH v6 2/4] clk: zx: add clock support to zx296702
In-Reply-To: <1433388063-13682-3-git-send-email-jun.nie@linaro.org>
References: <1433388063-13682-1-git-send-email-jun.nie@linaro.org>
 <1433388063-13682-3-git-send-email-jun.nie@linaro.org>
Message-ID: <5413289.jdeU1OgSi4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 June 2015 11:21:01 Jun Nie wrote:
> It adds a clock driver for zx296702 SoC to register the clock tree to
> Common Clock Framework.  All the clocks of bus topology and some the
> peripheral clocks are ready with this commit. Some missing leaf clocks
> for peripherals will be added later when needed.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> 

I'll wait for Ack from the drivers/clk maintainers before applying this.

	Arnd
