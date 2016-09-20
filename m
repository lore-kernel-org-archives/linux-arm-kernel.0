From: davem@davemloft.net (David Miller)
Date: Mon, 19 Sep 2016 21:40:18 -0400 (EDT)
Subject: [PATCH 1/2] net: ethernet: broadcom: bcm63xx: use phydev from
 struct net_device
In-Reply-To: <1474210747-19627-1-git-send-email-tremyfr@gmail.com>
References: <1474210747-19627-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20160919.214018.1924681039435420417.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sun, 18 Sep 2016 16:59:06 +0200

> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phydev in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
