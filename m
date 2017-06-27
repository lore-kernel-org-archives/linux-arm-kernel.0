From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Jun 2017 16:46:49 +0200
Subject: [PATCH 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <38394157-adae-3476-55f3-ab5838744033@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498192929-7519-2-git-send-email-david.wu@rock-chips.com>
 <20170624021910.GB4875@lunn.ch>
 <38394157-adae-3476-55f3-ab5838744033@rock-chips.com>
Message-ID: <20170627144649.GD9921@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> it has been licensed from somebody.

And does that somebody already have a driver for it? There is no point
adding a driver, if all you need to do is add the ID to another
driver.

	Andrew
