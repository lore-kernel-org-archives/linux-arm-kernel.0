From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 12:36:06 -0400
Subject: [PATCH 1/1] ARM: kirkwood: Fix chip-delay for GoFlex Net
In-Reply-To: <51476198.2080100@gmail.com>
References: <51476198.2080100@gmail.com>
Message-ID: <20130328163606.GU13280@titan.lakedaemon.net>
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

[1] (see below)

>  arch/arm/boot/dts/kirkwood-goflexnet.dts | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes.

I cleaned up the commit message to remove the conversational pieces.  In
the future, you can place this type of info here [1].  When patches are
applied from an email message, everything after the Subject line and
before the '---' becomes the commit message.

I've also Cc'd this to stable for v3.6.x and newer.

thx,

Jason.
