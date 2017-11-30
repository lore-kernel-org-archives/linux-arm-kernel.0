From: bhaskar.upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Thu, 30 Nov 2017 17:16:48 +0000
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <20171130155050.GD7483@lunn.ch>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
Message-ID: <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
	Please find answer in lined.
Regards
--Bhaskar
	

-----Original Message-----
From: Andrew Lunn [mailto:andrew at lunn.ch] 
Sent: Thursday, November 30, 2017 9:21 PM
To: Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>
Cc: netdev at vger.kernel.org; davem at davemloft.net; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 1/1] phy: Add 2.5G SGMII interface mode

On Thu, Nov 30, 2017 at 10:00:35AM +0530, Bhaskar Upadhaya wrote:
> Add 2.5G SGMII interface mode(PHY_INTERFACE_MODE_2500SGMII)
> in existing phy_interface list.As auto-negotiation is not supported 
> for 2.5G SGMII

Hi Bhaskar

I've been thinking about this some more...

Is auto negotiation not supported in 2.5G SGMII in general, or just in the system you are using? Is it the PHY or the MAC which does not support it.
[bhaskar] 2.5G in general needs to operate with auto negotiation in disabled mode. Its 2.5G requirement and not specific to our system.
 Are we going to get into trouble if we find an 2.5G SGMII link which does negotiate?

My understanding is that one of the main differences between SGMII and 1000BASE-X is the negotiation.
[Bhaskar] which of SGMII and 1000BASE-X support negotiation ?

	   Andrew
