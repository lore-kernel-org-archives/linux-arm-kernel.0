From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Apr 2018 14:40:06 +0200
Subject: [PATCH  1/8] net: ethernet: stmmac: add adaptation for
 stm32mp157c.
In-Reply-To: <fa12bb221b1b4cf380812c0fed03f74d@SFHDAG5NODE3.st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-2-git-send-email-christophe.roullier@st.com>
 <20180424153953.GB2360@lunn.ch>
 <fa12bb221b1b4cf380812c0fed03f74d@SFHDAG5NODE3.st.com>
Message-ID: <20180425124006.GB13486@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 07:12:29AM +0000, Christophe ROULLIER wrote:
> Hi Andrew,
> 
> For moment, I've only tested with PHY RGMII, RMII, MII, GMII, I do not have other kind of PHY interface.
> Normally there is no impact in my glue, the value of syscfg register will be the same for RGMII/ID/TXID/RXID.
> Do you think that I should add these interfaces in my case ?
> 
> 	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:

Yes

	Andrew
