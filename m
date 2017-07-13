From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jul 2017 10:18:12 +0200
Subject: [PATCH] arm64: dts: r8a7796: Add missing second pair of DMA
 names to MSIOF nodes
In-Reply-To: <1499855753-21630-1-git-send-email-geert+renesas@glider.be>
References: <1499855753-21630-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170713081811.GN5580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 12:35:53PM +0200, Geert Uytterhoeven wrote:
> MSIOF0 and MSIOF1 are tied to two DMA controllers through two pairs of
> DMA specifiers.  However, the second pair of corresponding DMA names was
> missing.
> 
> Fixes: 80fab06e258da762 ("arm64: dts: r8a7796: Add all MSIOF nodes")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied for v4.14.

Let me know if you would prefer it handled as a fix for v4.13.
I see the commit it fixes was part of v4.11.
