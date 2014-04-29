From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Apr 2014 20:21:32 -0400
Subject: [PATCH 93/97] ARM: l2c: convert mvebu to generic l2c
 initialisation
In-Reply-To: <E1WerJX-0001a0-6K@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerJX-0001a0-6K@rmk-PC.arm.linux.org.uk>
Message-ID: <20140429002132.GD28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 08:34:07PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Are you taking this, or shall I?  We already have one trivial conflict
with your UL patch.  This won't be any worse than that, so

Acked-by: Jason Cooper <jason@lakedaemon.net>

Otherwise, just let me know and I'll pick it up.

thx,

Jason.
