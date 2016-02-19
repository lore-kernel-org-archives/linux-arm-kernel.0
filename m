From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 19 Feb 2016 16:52:24 -0500 (EST)
Subject: [PATCH] usb: move usb_calc_bus_time into common code
In-Reply-To: <1455918064-410571-1-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1602191650570.1700-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016, Arnd Bergmann wrote:

> The dwc2 dual-role USB controller driver has started calling
> usb_calc_bus_time, and does so regardless of whether it is
> being built as a host controller or gadget. In case all

Out of curiosity...  Why does dwc2 need to calculate bus times when it
is in device mode?

Alan Stern
