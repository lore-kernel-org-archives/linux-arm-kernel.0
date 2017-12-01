From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 1 Dec 2017 20:12:50 +0100
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <AM3PR04MB449A2C7FDF78431360961E48C390@AM3PR04MB449.eurprd04.prod.outlook.com>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
 <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
 <20171130174127.GA28828@lunn.ch>
 <20171130181520.GF10595@n2100.armlinux.org.uk>
 <20171130182621.GC28828@lunn.ch>
 <20171130185300.GG10595@n2100.armlinux.org.uk>
 <AM3PR04MB449A2C7FDF78431360961E48C390@AM3PR04MB449.eurprd04.prod.outlook.com>
Message-ID: <20171201191250.GG22599@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So do we need to introduce a new interface type
> PHY_INTERFACE_MODE_2500SGMII or is there a way to deal with 2.5G
> SGMII ?

And just adding to what Florian said, you don't just add a new define
like this, you also need to add a user of it. Posting your MAC and PHY
driver making use of this symbol will make it a lot clearer why it is
needed and how it should be used.

       Andrew
