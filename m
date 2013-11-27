From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Nov 2013 14:17:47 +0900
Subject: [PATCH RFC v2 15/17] ARM: shmobile: Remove non-multiplatform
 Marzen reference support
In-Reply-To: <1902966.4sLBPLdrZF@avalon>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <1385451139-29686-16-git-send-email-horms+renesas@verge.net.au>
 <1902966.4sLBPLdrZF@avalon>
Message-ID: <20131127051746.GI27704@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:52:54PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Tuesday 26 November 2013 16:32:17 Simon Horman wrote:
> > Now that r8a7779 has CCF support remove the legacy Marzen reference
> > Kconfig bits CONFIG_MACH_MARZEN_REFERENCE for the non-multiplatform
> > case.
> > 
> > Starting from this commit Marzen board support is always enabled via
> > CONFIG_MACH_MARZEN, and CONFIG_ARCH_MULTIPLATFORM is used to select
> > between board-marzen.c and board-marzen-reference.c
> > 
> > The file board-marzen-reference.c can no longer be used together with
> > the legacy sh-clk clock framework, instead CCF is used.
> 
> You should then modify it to remove the #ifdef CONFIG_COMMON_CLK conditional 
> compilation.

Thanks, will do.
