From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 May 2017 13:56:02 +0200
Subject: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
In-Reply-To: <20170517171726.2ede556d@xhacker>
References: <20170516061720.1755-1-jszhang@marvell.com>
 <20170516122211.GA27959@lunn.ch> <20170517171726.2ede556d@xhacker>
Message-ID: <20170517115602.GD19968@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> As pointed out by RMK, the sdhci-xenon driver is merged in current 4.12-rc1,
> so we just need to apply this fix in later rcN.

Yep. It helps the maintainer if you point this out in the patch, after
the ---.

    Andrew
