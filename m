From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 19 May 2013 16:24:05 -0400
Subject: [PATCH] arm: kirkwood: use the default of match table
In-Reply-To: <1368626700-29226-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368626700-29226-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130519202405.GM11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 04:04:59PM +0200, Thomas Petazzoni wrote:
> mach-kirkwood/board-dt.c defines its own OF matching table, but in
> fact, it is the same to the default of_default_bus_match_table[] which
> is already used by mach-mvebu, mach-dove and mach-orion5x.
> 
> This patch therefore makes mach-kirkwood use the same default OF
> matching table.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/board-dt.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied to mvebu/soc

thx,

Jason.
