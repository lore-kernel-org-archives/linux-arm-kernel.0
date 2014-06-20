From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:51:47 -0400
Subject: [PATCHv4 1/4] ARM: Kirkwood: Add setup file for netxbig LEDs
In-Reply-To: <1401132591-26305-2-git-send-email-andrew@lunn.ch>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140620205147.GL21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 09:29:48PM +0200, Andrew Lunn wrote:
> There is currently no DT binding for the CPLD which controls the LEDs
> on the Net 2Big and Net 5Big. So use a platform device.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> v3-v4:
>   rename board-nextbig.c to nextbig.c
> ---
>  arch/arm/mach-mvebu/Kconfig    |   7 ++
>  arch/arm/mach-mvebu/Makefile   |   1 +
>  arch/arm/mach-mvebu/board.h    |   5 ++
>  arch/arm/mach-mvebu/kirkwood.c |   3 +
>  arch/arm/mach-mvebu/netxbig.c  | 191 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 207 insertions(+)
>  create mode 100644 arch/arm/mach-mvebu/netxbig.c

Applied to mvebu/soc

thx,

Jason.
