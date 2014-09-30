From: davem@davemloft.net (David Miller)
Date: Tue, 30 Sep 2014 01:31:13 -0400 (EDT)
Subject: [PATCH RESEND v6 0/7] net: cpsw: Support for am335x chip MACIDs
In-Reply-To: <1411973599-18908-1-git-send-email-mpa@pengutronix.de>
References: <1411973599-18908-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140930.013113.1095845408759260547.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutronix.de>
Date: Mon, 29 Sep 2014 08:53:12 +0200

> Another resend of this series to add the netdev list.
> 
> This series adds support to the cpsw driver to read the MACIDs of the am335x
> chip and use them as fallback. These addresses are only used if there are no
> mac addresses in the devicetree, for example set by a bootloader.

Series applied to net-next, thanks.
