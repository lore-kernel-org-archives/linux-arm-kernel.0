From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Oct 2013 10:47:41 -0400
Subject: [PATCH] ARM: kirkwood: remove lagacy clk workarounds
In-Reply-To: <1382097253-15624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1382097253-15624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131018144741.GL22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 01:54:13PM +0200, Sebastian Hesselbarth wrote:
> With legacy devices converted to DT and a proper ethernet MAC
> workaround, we can now remove the clk workarounds for legacy
> devices. While at it, also cleanup the list of includes.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> As a follow-up patch for latest mvebu PRs, this patch is based on
>  git://git.infradead.org/linux-mvebu.git tags/soc-3.13-2
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-kirkwood/board-dt.c |   42 ++----------------------------------
>  1 files changed, 3 insertions(+), 39 deletions(-)

Applied to mvebu/soc

thx,

Jason.
