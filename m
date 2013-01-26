From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 14:59:46 -0500
Subject: [PATCH 2/3] ARM: Kirkwood: Revert clkdev changes.
In-Reply-To: <1359213030-18588-3-git-send-email-andrew@lunn.ch>
References: <1359213030-18588-1-git-send-email-andrew@lunn.ch>
 <1359213030-18588-3-git-send-email-andrew@lunn.ch>
Message-ID: <20130126195946.GP1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 04:10:29PM +0100, Andrew Lunn wrote:
> Now that the Ethernet driver can get its clock from device tree,
> revert this change which broken non-DT probing of the ethernet device.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/board-dt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Squashed in,

thx,

Jason.
