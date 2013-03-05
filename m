From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Mar 2013 09:00:25 -0500
Subject: [PATCH] ARM: dove: Fix typo "COMMON_CLK_DOVE"
In-Reply-To: <1362476098.16460.65.camel@x61.thuisdomein>
References: <1362476098.16460.65.camel@x61.thuisdomein>
Message-ID: <20130305140025.GO23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Tue, Mar 05, 2013 at 10:34:58AM +0100, Paul Bolle wrote:
> Commit 5b03df9ace680d7cdd34a69dfd85ca5f74159d18 ("ARM: dove: switch to
> DT clock providers") added "select COMMON_CLK_DOVE" to Marvell Dove's
> Kconfig entry. But there's no Kconfig symbol COMMON_CLK_DOVE, which
> makes this select statement a nop. Since the Marvell Dove code includes
> <linux/clk-provider.h> we can assume that this entry needs to select
> COMMON_CLK instead.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch, thanks for the patch.  Sebastian, could you test this and
report back?

thx,

Jason.
