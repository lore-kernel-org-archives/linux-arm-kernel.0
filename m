From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Aug 2017 20:07:57 +0200
Subject: [PATCH net-next v2 00/10] net: mvpp2: MAC/GoP configuration
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822180757.GD18076@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 07:08:20PM +0200, Antoine Tenart wrote:
> Hi all,
> 
> This is based on net-next (e2a7c34fb285).
> 
> I removed the GoP interrupt and PHY optional parts in this v2 to ease
> the review process as the MAC/GoP initialization seemed to start less
> discussions :)

Hi Antoine

By that, do you mean setting the SMI PHY address?

   Andrew
