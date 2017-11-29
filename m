From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 22:20:37 +0800
Subject: [PATCH] ARM: imx: don't abort MMDC probe if power saving status
 doesn't match
In-Reply-To: <20171127121139.15584-1-l.stach@pengutronix.de>
References: <20171127121139.15584-1-l.stach@pengutronix.de>
Message-ID: <20171129142036.GN9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:11:39PM +0100, Lucas Stach wrote:
> The power saving status bit will not signal if the MMDC is under load,
> which is likely during kernel boot. There is no point in checking this
> bit and aborting the probe, as there is nothing depending on power
> saving being enabled, so we can trust the memory controller to enable
> power saving when we allow it.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
