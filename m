From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 24 Feb 2017 19:56:48 +0800
Subject: [PATCH net-next v3 0/4] net: mvneta: improve rx/tx performance
In-Reply-To: <20170221.111602.860315087619854954.davem@davemloft.net>
References: <20170220125344.3555-1-jszhang@marvell.com>
 <877f4laqog.fsf@free-electrons.com>	<20170221123726.2db7db19@xhacker>
 <20170221.111602.860315087619854954.davem@davemloft.net>
Message-ID: <20170224195648.219d6b50@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David, Marcin,

On Tue, 21 Feb 2017 11:16:02 -0500 David Miller wrote:

> From: Jisheng Zhang <jszhang@marvell.com>
> Date: Tue, 21 Feb 2017 12:37:40 +0800
> 
> > Thanks for your review.
> > 
> > The measurement is simple: record how much time we spent in mvneta_rx_swbm()
> > for receiving 1GB data, something as below:  
> 
> Please use a standard tool for measuring performance, rather than profiling
> the driver and trying to derive numbers that way.

Got your point. I will try to get performance with standard tool and cook a
v4 once rc1 is released.

Thanks,
Jisheng
