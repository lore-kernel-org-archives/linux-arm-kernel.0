From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Jun 2015 12:06:04 -0700
Subject: [PATCH v6 2/4] clk: zx: add clock support to zx296702
In-Reply-To: <5413289.jdeU1OgSi4@wuerfel>
References: <1433388063-13682-1-git-send-email-jun.nie@linaro.org>
 <1433388063-13682-3-git-send-email-jun.nie@linaro.org>
 <5413289.jdeU1OgSi4@wuerfel>
Message-ID: <20150605190604.GA648@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05, Arnd Bergmann wrote:
> On Thursday 04 June 2015 11:21:01 Jun Nie wrote:
> > It adds a clock driver for zx296702 SoC to register the clock tree to
> > Common Clock Framework.  All the clocks of bus topology and some the
> > peripheral clocks are ready with this commit. Some missing leaf clocks
> > for peripherals will be added later when needed.
> > 
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > 
> 
> I'll wait for Ack from the drivers/clk maintainers before applying this.
> 

Sent already as <20150604182526.GG490@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
