From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Nov 2017 16:50:50 +0100
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <20171130155050.GD7483@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 10:00:35AM +0530, Bhaskar Upadhaya wrote:
> Add 2.5G SGMII interface mode(PHY_INTERFACE_MODE_2500SGMII)
> in existing phy_interface list.As auto-negotiation is not
> supported for 2.5G SGMII

Hi Bhaskar

I've been thinking about this some more...

Is auto negotiation not supported in 2.5G SGMII in general, or just in
the system you are using? Is it the PHY or the MAC which does not
support it. Are we going to get into trouble if we find an 2.5G SGMII
link which does negotiate?

My understanding is that one of the main differences between SGMII and
1000BASE-X is the negotiation.

	   Andrew
