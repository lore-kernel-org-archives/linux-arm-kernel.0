From: davem@davemloft.net (David Miller)
Date: Mon, 24 Mar 2014 00:37:58 -0400 (EDT)
Subject: [PATCH] net: micrel : ks8851-ml: add vdd-supply support
In-Reply-To: <1395384768-8461-1-git-send-email-nm@ti.com>
References: <1395384768-8461-1-git-send-email-nm@ti.com>
Message-ID: <20140324.003758.1244022408748408267.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>
Date: Fri, 21 Mar 2014 01:52:48 -0500

> Few platforms use external regulator to keep the ethernet MAC supplied.
> So, request and enable the regulator for driver functionality.
> 
> Fixes: 66fda75f47dc (regulator: core: Replace direct ops->disable usage)
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Suggested-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied, thanks.
