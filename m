From: davem@davemloft.net (David Miller)
Date: Wed, 22 Jun 2016 16:25:42 -0400 (EDT)
Subject: [PATCH 1/2] net: ethernet: sun4i-emac: use phydev from struct
 net_device
In-Reply-To: <1466255740-20999-1-git-send-email-tremyfr@gmail.com>
References: <1466255740-20999-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20160622.162542.1929166668685308741.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sat, 18 Jun 2016 15:15:39 +0200

> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phydev in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied
