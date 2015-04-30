From: davem@davemloft.net (David Miller)
Date: Thu, 30 Apr 2015 16:49:12 -0400 (EDT)
Subject: [PATCH] net: fec: Fix RGMII-ID mode
In-Reply-To: <1430406470-26907-1-git-send-email-mpa@pengutronix.de>
References: <1430406470-26907-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150430.164912.1699155158792270511.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutronix.de>
Date: Thu, 30 Apr 2015 17:07:50 +0200

> RGMII-ID uses an internal delay within the transmitter or receiver. This
> feature is phy specific. The rest of the communication is normal RGMII.
> 
> So the fec driver has to check for all RGMII modes, not only
> 'PHY_INTERFACE_MODE_RGMII'.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied, thank you.
