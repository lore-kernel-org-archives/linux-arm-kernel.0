From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 21:12:25 -0400
Subject: [PATCH v2 2/9] ARM: Kirkwood: Remove platform driver for codec
In-Reply-To: <1399141819-23924-3-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140505011225.GF28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 08:30:12PM +0200, Andrew Lunn wrote:
> Remove the platform driver and platform data for the audio codec.
> A DT node will replace it.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/board-t5325.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Patches 2 and 6 applied to mvebu/soc.

thx,

Jason.
