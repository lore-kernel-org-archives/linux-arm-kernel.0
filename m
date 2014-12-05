From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 5 Dec 2014 10:25:03 -0500
Subject: [PATCH 2/5] ARM: mvebu: Add UART1 as DEBUG_LL possible target
In-Reply-To: <1417790698-9792-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141205152503.GE22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Fri, Dec 05, 2014 at 03:44:55PM +0100, Maxime Ripard wrote:
> Some mvebu boards have the UART1 more easily accessible than the other UARTs
> found on the system.
> 
> Add a debug_ll option for this case.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/Kconfig.debug | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

It looks to me like patches 1 and 2 should go through
Russell's patch tracker.  Is it worth having two patches?

In either case,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
