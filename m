From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Sep 2012 22:17:25 +0800
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <1348007837-23187-1-git-send-email-marex@denx.de>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
Message-ID: <20120919141723.GB2450@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 12:37:17AM +0200, Marek Vasut wrote:
> Don't load the FEC MAC address from OCOTP, but use the one supplied
> via device tree by U-Boot. This is the preferred way, every DT-capable
> bootloader does set up "mac-address" and "local-mac-address" properties
> into the DT passed to the kernel.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.
