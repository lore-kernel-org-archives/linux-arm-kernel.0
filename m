From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 4 Oct 2012 15:19:10 -0400 (EDT)
Subject: [PATCH 17/24 v2] ARM: cns3xxx: use OHCI platform driver
In-Reply-To: <1349363872-27004-18-git-send-email-florian@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1210041517091.1441-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Oct 2012, Florian Fainelli wrote:

> Since both the EHCI and OHCI platform drivers use the same power_{on,off}
> callbacks, rename them to cns3xx_usb_power_{on,off} to show that they are
> shared.

This is an example of the sort of thing I complained about before.  
People who read only the patch description and not the title will
wonder why this patch adds cns3xxx_usb_ohci_pdata and
cns3xxx_usb_ohci_device.

And people who read both will wonder why they talk about different 
things.

Alan Stern
