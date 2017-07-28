From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 28 Jul 2017 14:46:25 +0800
Subject: [PATCH v2 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <20170727134834.GD18666@lunn.ch>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
 <20170727134834.GD18666@lunn.ch>
Message-ID: <7764adcf-02c5-5ae1-1735-7f7e36790c30@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

? 2017/7/27 21:48, Andrew Lunn ??:
> I think we need to discuss this. This PHY appears to be on an MDIO
> bus, it uses a standard PHY driver, and it appears to be using an RMII
> interface. So it is just an ordinary PHY.
> 
> Internal is supposed to be something which is not ordinary, does not
> use one of the standard phy modes, needs something special to make it
> work.

Yes, it is a ordinary PHY in fact, using MDIO bus, but it is a internal 
phy inside Soc, so the "internal" is not the internal as Florain said.
