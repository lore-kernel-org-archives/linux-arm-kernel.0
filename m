From: davem@davemloft.net (David Miller)
Date: Wed, 29 Jun 2016 08:18:25 -0400 (EDT)
Subject: [PATCH 1/2] net: ethernet: lpc_eth: use phydev from struct
 net_device
In-Reply-To: <1467151185-31403-1-git-send-email-tremyfr@gmail.com>
References: <1467151185-31403-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20160629.081825.239459285788245816.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Tue, 28 Jun 2016 23:59:44 +0200

> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phydev in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
