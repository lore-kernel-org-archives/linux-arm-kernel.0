From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 5 Mar 2013 11:43:35 -0500 (EST)
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <20130305110457.GF7899@arwen.pp.htv.fi>
Message-ID: <Pine.LNX.4.44L0.1303051142400.1308-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Mar 2013, Felipe Balbi wrote:

> Anyway, details are as follows:
> 
> readl() and writel() always add a memory barrier around each operation.

Is that supposed to be true on all architectures or only on ARM?

Alan Stern
