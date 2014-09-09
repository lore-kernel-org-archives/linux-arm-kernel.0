From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 9 Sep 2014 12:05:16 -0400
Subject: [PATCH v2 3/5] ARM: mvebu: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1410167960-554-4-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
 <1410167960-554-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140909160516.GQ30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:19:18AM +0200, Philipp Zabel wrote:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to mvebu/dt

thx,

Jason.
