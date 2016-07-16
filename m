From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 18:44:54 +0200
Subject: [PATCH v0 09/10] net: phy: Re-attempt custom DT configuration
 after configuration
In-Reply-To: <1468679348-10522-10-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-10-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716164454.GK1777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:07PM +0100, Jamie Lentin wrote:
> marvell,reg-init is generally used to apply a custom LED configuration
> on boot. However this is then blatted in m88e1121_config_aneg when the
> interface is brought up. Re-apply any custom configuration afterwards,
> to keep custom LED configuration.

This has been fixed in net-next.

     Andrew
