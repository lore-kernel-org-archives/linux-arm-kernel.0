From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Mar 2013 15:33:35 -0400
Subject: [PATCH 1/1] ARM: kirkwood: Fix chip-delay for GoFlex Net
In-Reply-To: <51476198.2080100@gmail.com>
References: <51476198.2080100@gmail.com>
Message-ID: <20130318193335.GK13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 07:48:56PM +0100, Eric Hutter wrote:
> Hi,
> 
> This fixes "Too few good blocks within range" issues on GoFlex Net
> by setting chip-delay to 40. I've been using this patch on my device
> for quite a while now (accessing uboot vars is not possible without it).
> The basic problem was discussed at
> http://forum.doozan.com/read.php?2,7451 and I think this fix
> should go mainstream.
> 
> Greetings
> 
> Eric Hutter
> 
> 
> Signed-off-by: Eric Hutter <hutter.eric@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-goflexnet.dts | 1 +
>  1 file changed, 1 insertion(+)

Nice catch!  I'll include this in the next round of fixes I push.

thx,

Jason.
