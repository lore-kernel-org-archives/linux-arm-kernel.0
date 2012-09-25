From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 19:33:54 +0800
Subject: [PATCH] ARM i.MX dtsi: Add default bus-width property for esdhc
 controller
In-Reply-To: <1348566573-15210-1-git-send-email-s.hauer@pengutronix.de>
References: <1348566573-15210-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120925113352.GD14216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 11:49:33AM +0200, Sascha Hauer wrote:
> According to Documentation/devicetree/bindings/mmc/mmc.txt bus-width
> is a mandatory property. While this is currently enforced nowhere, it's
> a good habit to just add the property now to allow to add common helper
> functionality for the mmc property parsing later.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Queued for 3.8, thanks.
