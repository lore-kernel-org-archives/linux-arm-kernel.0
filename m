From: davem@davemloft.net (David Miller)
Date: Fri, 15 Jul 2016 16:43:17 -0700 (PDT)
Subject: [PATCH 1/2] net: ethernet: xilinx: axienet: use phydev from
 struct net_device
In-Reply-To: <1468518358-28735-1-git-send-email-tremyfr@gmail.com>
References: <1468518358-28735-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20160715.164317.1742262135870816587.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Thu, 14 Jul 2016 19:45:57 +0200

> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phy in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
