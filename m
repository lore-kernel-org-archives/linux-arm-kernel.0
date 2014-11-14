From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Nov 2014 21:50:16 +0100
Subject: [PATCH v2] ARM: mvebu: fix ordering in Armada 370 .dtsi
In-Reply-To: <20141114204333.GS27002@pengutronix.de>
References: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20141114204333.GS27002@pengutronix.de>
Message-ID: <20141114205016.GJ2001@lunn.ch>
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

Not at all.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
