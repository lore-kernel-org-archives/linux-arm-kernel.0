From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 16:50:46 -0500
Subject: [PATCH] ARM: Kirkwood: Cleanup unneeded include files
In-Reply-To: <1356697977-4105-1-git-send-email-andrew@lunn.ch>
References: <1356697977-4105-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130112215046.GG13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 01:32:57PM +0100, Andrew Lunn wrote:
> Remove include files which are no longer needed after converting
> to device tree.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/board-ib62x0.c  |    1 -
>  arch/arm/mach-kirkwood/board-mplcec4.c |    1 -
>  2 files changed, 2 deletions(-)

Applied to mvebu/cleanup

thx,

Jason.
