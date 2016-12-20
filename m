From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Dec 2016 16:37:00 +0100
Subject: [PATCH v2 2/3] net: dsa: mv88e6xxx: Add support for ethernet
 switch 88E6341/88E6141
In-Reply-To: <20161220085138.3998-3-romain.perier@free-electrons.com>
References: <20161220085138.3998-1-romain.perier@free-electrons.com>
 <20161220085138.3998-3-romain.perier@free-electrons.com>
Message-ID: <20161220153700.GB30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 09:51:37AM +0100, Romain Perier wrote:
> The Marvell 88E6341 device is single-chip, 6-port ethernet switch with
> four integrated 10/100/1000Mbps ethernet transceivers and one high speed
> SerDes interfaces. It is compatible with switches of family 88E6352.
> 
> This commit adds basic support for this switch by describing its
> capabilities to the driver.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
