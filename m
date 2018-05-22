From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 10:54:59 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add SMP support
In-Reply-To: <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
Message-ID: <20180522085459.4khvdbjbg5tw3rf5@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:19:44PM +0300, Sergei Shtylyov wrote:
> Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
> delivery masks for the ARM GIC and Architectured Timer.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'renesas-devel-20180516v2-v4.17-rc5' tag of Simon
> Horman's 'renesas.git' repo. Tested successfully on the V3M Starter Kit board
> (except offlining CPU0 hangs the kernel).

This looks fine but I will wait to see if there are other reviews completed
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
