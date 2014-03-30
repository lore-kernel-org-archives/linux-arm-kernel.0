From: marex@denx.de (Marek Vasut)
Date: Sun, 30 Mar 2014 19:29:29 +0200
Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
In-Reply-To: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <201403301929.29351.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 28, 2014 at 05:52:52 PM, Lucas Stach wrote:
> Allows fror proper refcounting of the parent clocks
> when enabling the clock output on CLK1/2 pads.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks OK:

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
