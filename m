From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 22:21:27 +0800
Subject: [PATCH] ARM: dts: imx6: phyFLEX: USB VBUS control is active-high
In-Reply-To: <1429624793-16223-1-git-send-email-p.zabel@pengutronix.de>
References: <1429624793-16223-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20150427142125.GB1567@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 03:59:53PM +0200, Philipp Zabel wrote:
> The fixed-regulator bindings require a separate property enable-active-high,
> the standard gpio phandle property polarity setting is ignored.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
