From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Sep 2016 00:03:44 +0200
Subject: [PATCH 6/8 v2] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <2920481.EgEQnLmOkM@wuerfel>
References: <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
 <1473109646-23366-1-git-send-email-jm@lentin.co.uk>
 <20160912170625.GA7420@rob-hp-laptop> <2920481.EgEQnLmOkM@wuerfel>
Message-ID: <20160912220344.GM11400@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Maybe we can instead leave out the PCI support from the new
> file for now and not delete the legacy board file?

Jamie, which interrupt do you see the WiFi card using?  If it is
IRQ_ORION5X_PCIE0_INT, (1 + 11), that is probably easier to deal with
than if it uses GPIO 4.

Thanks
     Andrew
