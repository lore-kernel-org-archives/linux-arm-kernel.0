From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 13 Sep 2014 17:51:23 -0400
Subject: [PATCH 6/8] arm: mach-orion5x: Convert pr_warning to pr_warn
In-Reply-To: <b438c7c54306f095a150e50df41fbba4d515c2f8.1410632835.git.joe@perches.com>
References: <cover.1410632834.git.joe@perches.com>
 <b438c7c54306f095a150e50df41fbba4d515c2f8.1410632835.git.joe@perches.com>
Message-ID: <20140913215123.GK30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe,

On Sat, Sep 13, 2014 at 11:31:17AM -0700, Joe Perches wrote:
> Use the more common pr_warn.
> 
> Other miscellanea:
> 
> o Realign arguments
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/mach-orion5x/dns323-setup.c           | 8 ++++----
>  arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
>  arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
>  arch/arm/mach-orion5x/ts409-setup.c            | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c           | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Applied to mvebu/soc with Andrew's Ack.

thx,

Jason.
