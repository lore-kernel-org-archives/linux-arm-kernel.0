From: davem@davemloft.net (David Miller)
Date: Mon, 19 Sep 2016 21:40:24 -0400 (EDT)
Subject: [PATCH 2/2] net: ethernet: broadcom: bcm63xx: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1474210747-19627-2-git-send-email-tremyfr@gmail.com>
References: <1474210747-19627-1-git-send-email-tremyfr@gmail.com>
 <1474210747-19627-2-git-send-email-tremyfr@gmail.com>
Message-ID: <20160919.214024.1975753880541871897.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sun, 18 Sep 2016 16:59:07 +0200

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
