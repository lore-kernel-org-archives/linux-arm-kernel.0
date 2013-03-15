From: davem@davemloft.net (David Miller)
Date: Fri, 15 Mar 2013 08:53:21 -0400 (EDT)
Subject: [PATCH 0/4] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <1363284515-9865-1-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
Message-ID: <20130315.085321.1047694772636447477.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <florian@openwrt.org>
Date: Thu, 14 Mar 2013 19:08:31 +0100

> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
> instead of rolling its own implementation. As a result, all users of this
> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
> The mvmdio driver is also updated to support an interrupt line which reports
> SMI error/completion, and to allow traditionnal platform device registration
> instead of just device tree.
> 
> David, I think it makes sense for you to merge all of this, since we do
> not want the architecture files to be desynchronized from the mv643xx_eth to
> avoid runtime breakage. The potential for merge conflicts should be very small.

All applied to net-next, thanks.
