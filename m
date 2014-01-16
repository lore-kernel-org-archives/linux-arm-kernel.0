From: davem@davemloft.net (David Miller)
Date: Wed, 15 Jan 2014 16:45:40 -0800 (PST)
Subject: [RFC PATCH net-next] etherdevice: Use ether_addr_copy to copy
 an Ethernet address
In-Reply-To: <1389830878.14001.39.camel@joe-AO722>
References: <1389741527.24849.68.camel@joe-AO722>
 <20140115.153951.743060257410154565.davem@davemloft.net>
 <1389830878.14001.39.camel@joe-AO722>
Message-ID: <20140115.164540.450877805879786067.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Wed, 15 Jan 2014 16:07:58 -0800

> If you want the ones for net-next net/ now (but not
> for batman-adv, that maybe could use a new function like
> ether_addr_copy_unaligned) here's a changestat.
> 
> Otherwise, I'll wait for the next cycle.

This looks fine, why don't you toss it my way over the weekend as I
still have some backlog to process at the moment?

Thanks.
