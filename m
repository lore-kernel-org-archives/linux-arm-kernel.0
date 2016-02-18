From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 18 Feb 2016 13:46:23 -0500 (EST)
Subject: [PATCH v5 1/1] USB: core: let USB device know device node
In-Reply-To: <1455612172-2081-1-git-send-email-peter.chen@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1602181345570.1280-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016, Peter Chen wrote:

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

Acked-by: Alan Stern <stern@rowland.harvard.edu>
