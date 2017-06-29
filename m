From: davem@davemloft.net (David Miller)
Date: Thu, 29 Jun 2017 12:25:58 -0400 (EDT)
Subject: [PATCH] cavium: thunder: Remove duplicate "netdev->name"
 logging output
In-Reply-To: <0ac1a144114eecd8c469027d6c91f453d61e1ade.1498560984.git.joe@perches.com>
References: <0ac1a144114eecd8c469027d6c91f453d61e1ade.1498560984.git.joe@perches.com>
Message-ID: <20170629.122558.2257692860243246268.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Tue, 27 Jun 2017 03:56:54 -0700

> Using netdev_<level>(netdev, "%s: ...", netdev->name) duplicates the
> name in the output.  Remove those uses.
> 
> Miscellanea:
> 
> o Use the netif_<level> convenience macros at the same time
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to net-next.
