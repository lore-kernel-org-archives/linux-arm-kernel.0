From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 28 Jan 2013 12:34:16 -0500 (EST)
Subject: [PATCH v2 11/30] usb: ehci-omap: Remove PHY reset handling code
In-Reply-To: <1359372631-8180-12-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301281233590.1997-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Roger Quadros wrote:

> Reset GPIO handling for the PHY must be done in the PHY
> driver. We use the PHY helpers instead to reset the PHY.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
