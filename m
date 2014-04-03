From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Apr 2014 14:49:08 +0800
Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
In-Reply-To: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140403064906.GI2801@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 05:52:52PM +0100, Lucas Stach wrote:
> Allows fror proper refcounting of the parent clocks
> when enabling the clock output on CLK1/2 pads.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
