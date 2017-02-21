From: davem@davemloft.net (David Miller)
Date: Tue, 21 Feb 2017 11:16:02 -0500 (EST)
Subject: [PATCH net-next v3 0/4] net: mvneta: improve rx/tx performance
In-Reply-To: <20170221123726.2db7db19@xhacker>
References: <20170220125344.3555-1-jszhang@marvell.com>
 <877f4laqog.fsf@free-electrons.com>
 <20170221123726.2db7db19@xhacker>
Message-ID: <20170221.111602.860315087619854954.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Tue, 21 Feb 2017 12:37:40 +0800

> Thanks for your review.
> 
> The measurement is simple: record how much time we spent in mvneta_rx_swbm()
> for receiving 1GB data, something as below:

Please use a standard tool for measuring performance, rather than profiling
the driver and trying to derive numbers that way.
