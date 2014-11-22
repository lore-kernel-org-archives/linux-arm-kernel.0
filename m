From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 22:37:44 -0500
Subject: [PATCH v2] ARM: mvebu: fix ordering in Armada 370 .dtsi
In-Reply-To: <20141114204333.GS27002@pengutronix.de>
References: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20141114204333.GS27002@pengutronix.de>
Message-ID: <20141122033744.GS22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 09:43:33PM +0100, Uwe Kleine-K?nig wrote:
> Commit a095b1c78a35 ("ARM: mvebu: sort DT nodes by address")
> missed placing the system-controller in the correct order.                                                                                                               
> 
> Fixes: a095b1c78a35 ("ARM: mvebu: sort DT nodes by address")
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello Andrew,
> 
> I guess your question concerning overlapping ranges doesn't stop this
> patch from being useful, does it?
> 
> Also thanks for the suggested wording which I nearly took as is.
> 
> Best regards
> Uwe
> 
>  arch/arm/boot/dts/armada-370.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to mvebu/dt with Andrew's Ack.

thx,

Jason.
