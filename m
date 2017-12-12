From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Dec 2017 12:44:59 +0100
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev: use XAUI for DSA link ports
In-Reply-To: <E1eOgsp-0001Ab-9x@rmk-PC.armlinux.org.uk>
References: <E1eOgsp-0001Ab-9x@rmk-PC.armlinux.org.uk>
Message-ID: <20171212114459.GP28672@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:29:51AM +0000, Russell King wrote:
> Use XAUI rather than XGMII for DSA link ports, as this is the interface
> mode that the switches actually use. XAUI is the 4 lane bus with clock
> per direction, whereas XGMII is a 32 bit bus with clock.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
