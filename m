From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 09:52:49 +0900
Subject: [PATCH] ARM: shmobile: Fix EMEV2 clock comment typo
In-Reply-To: <20130708062005.25694.62165.sendpatchset@w520>
References: <20130708062005.25694.62165.sendpatchset@w520>
Message-ID: <20130710005248.GD32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:20:05PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the STI timer frequency comment to 32.768 kHz to
> fix 37 kHz typo.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against "renesas-next-20130704v2"
> 
>  arch/arm/mach-shmobile/clock-emev2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
