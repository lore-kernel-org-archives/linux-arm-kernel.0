From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 11:41:08 +0800
Subject: [PATCH] ARM: dts: imx6qdl: don't configure reserved pad settings
In-Reply-To: <1468012974-27180-1-git-send-email-uwe@kleine-koenig.org>
References: <1468012974-27180-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <20160809034107.GL4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:22:54PM +0200, Uwe Kleine-K?nig wrote:
> Several dts files set a bit in the SPEED field for pads
> RGMII_{R,T}{XC,D0,D1,D2,D3,X_CTL}, but that doesn't exist. Writing there
> doesn't have an effect and the bit reads as zero.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Applied, thanks.
