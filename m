From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Oct 2018 01:14:52 +0200
Subject: [PATCH 9/9] net: phy: mdio-mux-bcm-iproc: simplify getting
 .driver_data
In-Reply-To: <20181021200021.1693-10-wsa+renesas@sang-engineering.com>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
 <20181021200021.1693-10-wsa+renesas@sang-engineering.com>
Message-ID: <20181021231452.GC12539@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 10:00:20PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
