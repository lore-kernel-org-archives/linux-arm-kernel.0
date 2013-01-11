From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 11 Jan 2013 10:28:57 -0500 (EST)
Subject: [PATCH 07/14] usb: ehci-omap: Instantiate PHY devices if required
In-Reply-To: <50EFF075.5090203@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301111019340.1730-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013, Roger Quadros wrote:

> Alan,
> 
> Thanks for the patch. I've pasted the version that builds and works and
> put you as the Author of the patch, hope it is fine.

As far as I can see, yours is the same as what I posted except that:

	You altered the changes to ehci-hcd.c and Makefile to remove 
	the dependency on the ehci-mxc patch;

	You made an unimportant whitespace change in ehci-omap.c
	(moved a blank line before ehci_write()).

Right?  It's hard to compare the patches directly because the one you 
posted was whitespace-damaged.

Anyway, if this is okay and there's nothing wrong with the ehci-mxc 
change (other than the comment for ehci->priv), I'll submit both of 
them to Greg soon.

Alan Stern
