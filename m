From: davem@davemloft.net (David Miller)
Date: Mon, 19 Feb 2018 23:15:23 -0500 (EST)
Subject: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
In-Reply-To: <alpine.LNX.2.21.1802201108100.8@nippy.intranet>
References: <alpine.LNX.2.21.1802200844340.8@nippy.intranet>
 <20180219.184343.1801583131809551924.davem@davemloft.net>
 <alpine.LNX.2.21.1802201108100.8@nippy.intranet>
Message-ID: <20180219.231523.2226814242777657736.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 20 Feb 2018 11:42:26 +1100 (AEDT)

> If there was an unused variables I would happily remove that too but the 
> 'version' string is not unused. The etherh.c and mac8390.c files both 
> include "lib8390.c" and in there you'll find the 'version' string used in 
> ethdev_setup().

My bad, thanks for being so patient with me :)
