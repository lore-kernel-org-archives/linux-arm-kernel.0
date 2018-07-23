From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 18:08:27 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add RWDT support
In-Reply-To: <175a491f-a827-4a92-1884-2f1490d38a52@cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <175a491f-a827-4a92-1884-2f1490d38a52@cogentembedded.com>
Message-ID: <20180723160827.ziuivshq2mtagexq@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 10:21:45PM +0300, Sergei Shtylyov wrote:
> Describe RWDT in the R8A77980 SoC device tree.
> 
> Enable RWDT on the Condor and V3H Starter Kit boards.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'renesas-devel-20180720-v4.18-rc5' of Simon Horman's
> 'renesas.git' repo.  It depends on Geert Uytterhoeven's clock driver patches
> (adding the RWDT clock) in order to work...

But it is safe to apply without those patches, right?

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
