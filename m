From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 31 Jul 2013 20:31:05 -0400
Subject: [PATCH 16/18] ARM: orion: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-17-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-17-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130801003105.GU5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 03:31:15PM -0700, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/plat-orion/time.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
