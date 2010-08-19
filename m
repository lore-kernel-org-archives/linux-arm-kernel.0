From: davem@davemloft.net (David Miller)
Date: Thu, 19 Aug 2010 00:13:03 -0700 (PDT)
Subject: [PATCH v4] ether3: Use net_device_stats from struct net_device
In-Reply-To: <1282198531-4157-1-git-send-email-tklauser@distanz.ch>
References: <1282061733-19700-1-git-send-email-tklauser@distanz.ch>
	<1282198531-4157-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20100819.001303.235703853.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tobias Klauser <tklauser@distanz.ch>
Date: Thu, 19 Aug 2010 08:15:31 +0200

> struct net_device has its own struct net_device_stats member, so use
> this one instead of a private copy in the ether1_priv struct. As the new
> ndo_get_stats function would just return dev->stats we can omit it. This
> patch also removes an incorrect memset of the stats on open.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Applied, thanks.
