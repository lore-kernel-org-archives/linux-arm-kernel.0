From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 26 Oct 2012 10:54:04 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <20121026080254.GD3009@breakpoint.cc>
Message-ID: <Pine.LNX.4.44L0.1210261052230.6007-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2012, Sebastian Andrzej Siewior wrote:

> On Thu, Oct 25, 2012 at 10:36:14AM -0400, Alan Stern wrote:
> > What happens if the drivers get probed in the wrong order?  That is, if 
> > ehci-platform gets probed before ehci-spear (or whatever)?
> 
> The "wrong" driver may get loaded.

That's my point.  That's why ehci-platform.c should not claim to match 
all devices listing "usb-ehci" in their compatible property.

Alan Stern
