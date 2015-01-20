From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 20 Jan 2015 14:40:43 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <54BE58DA.7050707@ti.com>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com> <20150116191734.GB31577@lunn.ch>
 <54BE258A.10808@ti.com> <20150120132613.GJ2938@lunn.ch>
 <54BE58DA.7050707@ti.com>
Message-ID: <20150120134043.GK2938@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Right. TLC591xx has the constant output mode which should be used for
> GPIO. Perhaps that mode could be always used when the brightness is
> turned to maximum. I haven't read the spec carefully enough to know if
> there are some downsides.

The original Belkin code did use that mode for full brightness. But it
added complexity to the code which i did not see a need for. Now you
need gpio support, i can add it back.

     Andrew
