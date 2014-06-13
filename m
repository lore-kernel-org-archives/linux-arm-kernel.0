From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jun 2014 09:45:33 +0200
Subject: [PATCH 1/2] ARM: dts: mx5: Fix IPU port node placement
In-Reply-To: <1402618960-9735-1-git-send-email-marex@denx.de>
References: <1402618960-9735-1-git-send-email-marex@denx.de>
Message-ID: <1402645533.3507.2.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 13.06.2014, 02:22 +0200 schrieb Marek Vasut:
> The "port" node was misplaced in the original patch, therefore making
> the LCD dysfunctional on this board. Fix this by moving the "port" DT
> node into the "display {}" node.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

thanks
Philipp
