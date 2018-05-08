From: davem@davemloft.net (David Miller)
Date: Mon, 07 May 2018 23:18:41 -0400 (EDT)
Subject: [PATCH net-next v2 00/13] net: mvpp2: phylink conversion
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180507.231841.206393937472731641.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  4 May 2018 15:56:30 +0200

> Also as the SFP cages on both DB boards can be considered as non-wired,
> the SFP code was reworked to really support when some pins of the SFP
> cage aren't described in the device tree. Also a warning was added when
> no Tx disable pin is available. (Patches 1-3).

I guess there is still discussion about whether fixed-link should be
used for this instead of SFP.
