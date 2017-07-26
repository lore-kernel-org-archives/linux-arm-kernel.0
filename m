From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Jul 2017 18:16:17 +0200
Subject: [PATCH net-next 07/18] net: mvpp2: initialize the GoP
In-Reply-To: <20170724134848.19330-8-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-8-antoine.tenart@free-electrons.com>
Message-ID: <20170726161617.GI12049@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	switch (port->phy_interface) {
> +	case PHY_INTERFACE_MODE_RGMII:

Here as well,

     Andrew
