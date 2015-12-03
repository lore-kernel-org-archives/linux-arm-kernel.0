From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Dec 2015 13:14:41 +0000
Subject: [PATCH 0/4] ARM: sun9i: Support Allwinner A80 NMI controller
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <20151203131441.GI6520@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:20:09PM +0800, Chen-Yu Tsai wrote:
> Patch 1 renames the binding doc, to remove the SoC specific bits from
> the filename.
> 
> Patch 2 adds a new compatible string for the A80 variant.
> 
> Patch 3 adds driver support for the A80 variant.

Applied to irqchip/sunxi.  Once this has had a day or two in -next, you
can consider it stable.  I'll also merge it into irqchip/core around
that time.  Added Maxime and Hans' tags.

thx,

Jason.
