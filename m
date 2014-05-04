From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 May 2014 20:39:40 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: remove power-on gpio from pcie
In-Reply-To: <1398854829-3447-1-git-send-email-l.stach@pengutronix.de>
References: <1398854829-3447-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140504123937.GA6475@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 12:47:09PM +0200, Lucas Stach wrote:
> This isn't compatible with the new binding and should be
> handled via a proper regulator. It shouldn't be needed as
> the driver has always ignored this property.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
