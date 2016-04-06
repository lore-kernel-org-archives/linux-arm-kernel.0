From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 6 Apr 2016 22:52:30 +0800
Subject: [PATCH BUGFIX] clk: imx6q: fix typo in CAN clock definition
In-Reply-To: <1459340583-14743-1-git-send-email-LW@KARO-electronics.de>
References: <1459340583-14743-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160406145230.GB4022@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 02:23:03PM +0200, Lothar Wa?mann wrote:
> commit ee36027427c7 ("clk: imx: Add clock support for imx6qp")
> introduced a regression due to a subtle typo in the 'can_root' clock
> definition. The effect is that trying to configure the bitrate of the
> can interfaces fails with -EDOM or produces a division by zero error
> due to the clock_freq of the can serial clock being reported as '0'.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
