From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Aug 2016 16:57:23 +0200
Subject: [PATCH 1/2] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <87bn0bhdwh.fsf@free-electrons.com>
References: <20160829110456.12206-1-sr@denx.de>
 <20160829125753.GC12465@lunn.ch>
 <87bn0bhdwh.fsf@free-electrons.com>
Message-ID: <20160829145723.GB17231@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Actually arm64 mvebu SoC such as the Armada 3700 do not have mbus bus
> but can still reuse the same driver than the other mvebu SoC. So in
> this case I would prefer that the function return an error.

O.K. An error would be good, assuming the code actually catches it.
I think the code change in patch [2/2] did not catch the error.

  Andrew
