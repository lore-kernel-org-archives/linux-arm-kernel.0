From: davem@davemloft.net (David Miller)
Date: Thu, 14 Jul 2016 17:43:02 -0700 (PDT)
Subject: [PATCH 1/2] net: ethernet: ll_temac: use phydev from struct
 net_device
In-Reply-To: <1468453732-7370-1-git-send-email-tremyfr@gmail.com>
References: <1468453732-7370-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20160714.174302.2206447776687968361.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Thu, 14 Jul 2016 01:48:51 +0200

> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phy in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
