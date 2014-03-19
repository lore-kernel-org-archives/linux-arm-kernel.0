From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Mar 2014 15:34:30 -0400
Subject: [PATCH 25/62] ARM: mvebu: add missing header
In-Reply-To: <1395257399-359545-26-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-26-git-send-email-arnd@arndb.de>
Message-ID: <20140319193430.GS15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:22PM +0100, Arnd Bergmann wrote:
> The definition for SIGBUS may not be visible without including
> linux/signal.h, as I found during randconfig testing.
> 
> Adding an explicit include is certainly the right thing to do.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
