From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 25 Jan 2018 10:55:47 -0500 (EST)
Subject: [RFC/RFT usb-next v1 3/6] usb: host: ehci-platform: remove custom
 USB PHY handling
In-Reply-To: <20180125001639.14681-4-martin.blumenstingl@googlemail.com>
Message-ID: <Pine.LNX.4.44L0.1801251055020.1531-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jan 2018, Martin Blumenstingl wrote:

> The new PHY wrapper is now wired up in the core HCD code. This means
> that PHYs are now controlled (initialized, enabled, disabled, exited)
> without requiring any host-driver specific code.
> Remove the custom USB PHY handling from the ehci-platform driver as the
> core HCD code now handles this.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

For patches 3/6 and 4/6:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
