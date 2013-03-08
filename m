From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 16:26:49 -0500
Subject: [PATCH v2] ARM: dove: drop "select COMMON_CLK_DOVE"
In-Reply-To: <1362514637.16460.117.camel@x61.thuisdomein>
References: <1362476098.16460.65.camel@x61.thuisdomein>
 <51363A9E.6090507@gmail.com>
 <1362514637.16460.117.camel@x61.thuisdomein>
Message-ID: <20130308212649.GS23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 09:17:17PM +0100, Paul Bolle wrote:
> Commit 5b03df9ace680d7cdd34a69dfd85ca5f74159d18 ("ARM: dove: switch to
> DT clock providers") added "select COMMON_CLK_DOVE" to Marvell Dove's
> Kconfig entry. But there's no Kconfig symbol COMMON_CLK_DOVE, which
> makes this select statement a nop. It's probably a leftover of some
> experimental code that never hit mainline. Drop it.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) v2: Sebastian suggested to drop this select entirely.
> 
> 1) Still untested.
> 
>  arch/arm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.
