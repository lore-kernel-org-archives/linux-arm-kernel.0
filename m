From: horms@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 10:17:19 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7793: Describe DMA for the serial
 ports
In-Reply-To: <1449796058-12160-1-git-send-email-horms+renesas@verge.net.au>
References: <1449796058-12160-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151211011719.GF9927@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 10:07:38AM +0900, Simon Horman wrote:
> Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.
> 
> Based on similar work for the r8a7791 by Geert Uytterhoeven.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Based on renesas-devel-20151210-v4.4-rc4
> 
> v2
> * Corrected dmas for scif1, thanks to Geert Uytterhoeven

For the record I have queued this up.
