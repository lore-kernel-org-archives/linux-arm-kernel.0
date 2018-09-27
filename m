From: davem@davemloft.net (David Miller)
Date: Wed, 26 Sep 2018 20:27:35 -0700 (PDT)
Subject: [PATCH net-next] net: mvneta: Add support for 2500Mbps SGMII
In-Reply-To: <20180925135939.4816-1-maxime.chevallier@bootlin.com>
References: <20180925135939.4816-1-maxime.chevallier@bootlin.com>
Message-ID: <20180926.202735.1750846894178423857.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 25 Sep 2018 15:59:39 +0200

> The mvneta controller can handle speeds up to 2500Mbps on the SGMII
> interface. This relies on serdes configuration, the lane must be
> configured at 3.125Gbps and we can't use in-band autoneg at that speed.
> 
> The main issue when supporting that speed on this particular controller
> is that the link partner can send ethernet frames with a shortened
> preamble, which if not explicitly enabled in the controller will cause
> unexpected behaviours.
> 
> This was tested on Armada 385, with the comphy configuration done in
> bootloader.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
