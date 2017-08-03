From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Aug 2017 15:44:01 +0200
Subject: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
In-Reply-To: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
References: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
Message-ID: <20170803134401.GG15018@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 12:00:27PM +0200, Peter Rosin wrote:
> Hi!
> 
> Texas has apparently made copies for some of the NXP devices
> handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.

This happens a lot in the i2c space. Look at all the at24 EEPROM
clones. Yet they all use the same compatible string.

	Andrew
