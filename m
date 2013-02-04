From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 4 Feb 2013 16:12:55 -0500 (EST)
Subject: [PATCH 06/13] USB: ohci-omap3: Get platform resources by index
 rather than by name
In-Reply-To: <1359993540-20780-7-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1302041612380.1756-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Feb 2013, Roger Quadros wrote:

> Since there is only one resource per type we don't really need
> to use resource name to obtain it. This also also makes it easier
> for device tree adaptation.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
