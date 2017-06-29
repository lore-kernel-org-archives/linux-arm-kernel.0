From: davem@davemloft.net (David Miller)
Date: Thu, 29 Jun 2017 12:23:49 -0400 (EDT)
Subject: [PATCH 1/6] net: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
References: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
Message-ID: <20170629.122349.2265868886957558079.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Tue, 27 Jun 2017 11:28:01 +0200

> The current way to find if the phy is internal is to compare DT phy-mode
> and emac_variant/internal_phy.
> But it will negate a possible future SoC where an external PHY use the
> same phy mode than the internal one.
> 
> By using phy-mode = "internal" we permit to have an external PHY with
> the same mode than the internal one.
> 
> Reported-by: Andr? Przywara <andre.przywara@arm.com>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Series applied.

Please provide a proper "[PATCH 0/n] " header posting next time.
