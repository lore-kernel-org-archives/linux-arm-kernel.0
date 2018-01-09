From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jan 2018 15:13:04 +0100
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109085945.11916-5-antoine.tenart@free-electrons.com>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
Message-ID: <20180109141304.GE27447@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
> driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
> nearly the same code path.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks for adding the comment.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
