From: davem@davemloft.net (David Miller)
Date: Thu, 30 Jun 2011 23:56:47 -0700 (PDT)
Subject: [PATCH net-next] net: am79c961a: Omit check for multicast bit
	in netdev_for_each_mc_addr
In-Reply-To: <1309349686-1506-1-git-send-email-tklauser@distanz.ch>
References: <1309349686-1506-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20110630.235647.1768047465126096152.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed, 29 Jun 2011 14:14:46 +0200

> There is no need to check for the address being a multicast address in
> the netdev_for_each_mc_addr loop, so remove it.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied.
