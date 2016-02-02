From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Feb 2016 14:31:47 +0800
Subject: [PATCH 3/6] ARM: dts: imx6qdl-tx6: add ENET_OUT clock to fec node
In-Reply-To: <1453294626-17608-4-git-send-email-LW@KARO-electronics.de>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
 <1453294626-17608-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160202063147.GF8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 01:57:03PM +0100, Lothar Wa?mann wrote:
> ENET_OUT is used as reference clock for the ethernet PHY on the Ka-Ro
> TX6 modules. Specify this clock in DTB to let it be managed correctly
> by the driver.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
