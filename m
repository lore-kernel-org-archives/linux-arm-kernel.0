From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 2 Mar 2018 22:56:14 +0100
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
Message-ID: <20180302215614.GD25189@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> Add SFP module support for Clearfog using the SFP phylink support.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Andrew Lunn <andrew@lunn.ch>

Using a RoboFiber SFP module, connected to a media converter. Link
up/down detected.

    Andrew
