From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 15:39:18 +0800
Subject: [PATCH] ARM: dts: imx6q-tbs2910: fix fec reset polarity
In-Reply-To: <1459868104-18191-1-git-send-email-smoch@web.de>
References: <1459868104-18191-1-git-send-email-smoch@web.de>
Message-ID: <20160412073918.GB23438@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 04:55:04PM +0200, Soeren Moch wrote:
> According to Documentation/devicetree/bindings/net/fsl-fec.txt the polarity
> of "phy-reset-gpios" is assumed to be active-low unless a separate property
> "phy-reset-active-high" is available. So replace the inconsistent polarity
> description to make the correct active-low reset behavior more obvious.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>

Applied, thanks.
