From: davem@davemloft.net (David Miller)
Date: Tue, 22 Aug 2017 14:32:50 -0700 (PDT)
Subject: [PATCH net-next v2 00/10] net: mvpp2: MAC/GoP configuration
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822.143250.1510952084327060303.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Tue, 22 Aug 2017 19:08:20 +0200

> This is based on net-next (e2a7c34fb285).
> 
> I removed the GoP interrupt and PHY optional parts in this v2 to ease
> the review process as the MAC/GoP initialization seemed to start less
> discussions :)
> 
> This series now only aims at making the PPv2 driver less depending on
> the firmware/bootloader initialization. Some patches cleanup some parts
> as well, and add new interface descriptions in the dt.
 ...
> @Dave: patches 9 and 10 should go through the mvebu tree. Thanks!

Patches 1-8 applied to net-next, thanks.
