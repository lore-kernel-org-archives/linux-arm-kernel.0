From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Sep 2017 15:55:29 +0200
Subject: [PATCH v2 1/4] arm64: dts: marvell: mcbin: add comphy references
 to Ethernet ports
In-Reply-To: <20170921075410.19072-2-antoine.tenart@free-electrons.com>
References: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
 <20170921075410.19072-2-antoine.tenart@free-electrons.com>
Message-ID: <20170921135529.GA27589@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 09:54:07AM +0200, Antoine Tenart wrote:
> This patch adds comphy phandles to the Ethernet ports in the mcbin
> device tree. The comphy is used to configure the serdes PHYs used by
> these ports.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Hi Antoine

This is much easier to understand. Thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
