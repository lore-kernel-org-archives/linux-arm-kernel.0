From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 24 Oct 2018 19:07:54 +0100
Subject: [PATCH v2 10/15] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <20181023155035.9101-11-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-11-jagan@amarulasolutions.com>
Message-ID: <20181024180754.pfae27y6i7jhcdgy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 09:20:30PM +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge panel,
> the same panel PCB comes with parallel RBG which is supported via
> panel-simple driver with "bananapi,s070wv20-ct16" compatible.
> 
> But this binding is specific for MIPI DSI to RGB bridge panels,
> which usually accessed using MIPI DSI controller driver.
> 
> for information:
> - "bananapi,s070wv20-ct16" compatible for parallel RGB panels
> - "bananapi,s070wv20-ct16-icn6211" compatible for MIPI-DSI to RGB
> bridge panels
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Why not just reusing the same binding document?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181024/9da1d5ea/attachment.sig>
