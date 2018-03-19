From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 19 Mar 2018 14:10:09 +0100
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
In-Reply-To: <20180319125953.GD19795@lunn.ch>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
Message-ID: <20180319131009.GJ4519@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Mar 19, 2018 at 01:59:53PM +0100, Andrew Lunn wrote:
> 
> If they don't have PHYs, how are the connected to the outside world?

On 7k/8k you have the following scheme for 10G only interfaces:

   MAC -- Comphy -- PHY -- SFP cage -- ...

Or

   MAC -- Comphy -- SFP cage -- ...

The comphy provides serdes lanes, and can be configured in various
modes (SGMII, 2500SGMII, 10GKR...).

Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
