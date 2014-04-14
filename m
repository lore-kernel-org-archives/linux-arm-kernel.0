From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Apr 2014 10:14:54 +0800
Subject: [PATCH 4/6] ARM: dts: vybrid: drop address and size cells from
 GIC node
In-Reply-To: <1397228380-7352-4-git-send-email-l.stach@pengutronix.de>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
 <1397228380-7352-4-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140414021451.GA2344@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 04:59:38PM +0200, Lucas Stach wrote:
> This is likely a copy-and-paste error from the
> ARM GIC documentation, that has already been fixed.
> 
> address-cells should have been set to 0, as with the size
> cells. As having those properties set to 0 is the
> same thing as not specifying them, drop them completely.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
