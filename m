From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 16:42:00 +0800
Subject: [PATCH] ARM: dts: imx6qdl: move HDMI controller to right
 location in DT
In-Reply-To: <1427880414-18503-1-git-send-email-l.stach@pengutronix.de>
References: <1427880414-18503-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20150427084159.GE9231@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 11:26:54AM +0200, Lucas Stach wrote:
> Currently the HDMI controller is a child device of the AIPS bus in the
> DT which is clearly wrong. Move it to the right location.
> This introduces no functional change it just aligns the DT representation
> with reality.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
