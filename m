From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 29 Jan 2013 10:30:05 -0500 (EST)
Subject: [PATCH v3 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <1359453032-20604-1-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301291026020.1507-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Roger Quadros wrote:

> For each port that is in PHY mode we obtain a PHY device using the USB PHY
> library and put it out of suspend.
> 
> It is up to platform code to associate the PHY to the controller's
> port and it is upto the PHY driver to manage the PHY's resources.

s/upto/up to/

> Also remove wired spacing around declarations we come across.

s/wired/weird/ -- not that people care about misspellings in the 
Changelog.  You don't have to resubmit the patch just to fix these two 
items.

> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
