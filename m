From: davem@davemloft.net (David Miller)
Date: Wed, 07 Jun 2017 15:08:36 -0400 (EDT)
Subject: [PATCH v2] net: mvpp2: do not bypass the mvpp22_port_mii_set
 function
In-Reply-To: <20170607061750.28516-1-antoine.tenart@free-electrons.com>
References: <20170607061750.28516-1-antoine.tenart@free-electrons.com>
Message-ID: <20170607.150836.1506071311612042001.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Wed,  7 Jun 2017 08:17:50 +0200

> The mvpp22_port_mii_set() function was added by 2697582144dd, but the
> function directly returns without doing anything. This return was used
> when debugging and wasn't removed before sending the patch. Fix this.
> 
> Fixes: 2697582144dd ("net: mvpp2: handle misc PPv2.1/PPv2.2 differences")
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied, thank you.
