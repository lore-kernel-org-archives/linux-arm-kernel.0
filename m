From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 11:15:06 +0100
Subject: [PATCH v6 1/1] USB: core: let USB device know device node
In-Reply-To: <1455873975-19531-1-git-send-email-peter.chen@nxp.com>
References: <1455873975-19531-1-git-send-email-peter.chen@nxp.com>
Message-ID: <2952220.GB2TbsskTM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 17:26:15 Peter Chen wrote:
> From: Peter Chen <peter.chen@freescale.com>
> 
> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> describe these at device tree.
> 
> In this commit, it uses "reg" in dts as physical port number to match
> the phyiscal port number decided by USB core, if they are the same,
> then the device node is for the device we are creating for USB core.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Rob Herring <robh@kernel.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
