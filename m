From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 15:23:23 +0100
Subject: [PATCH] arm64: dts: r8a7796: Add all MSIOF nodes
In-Reply-To: <1479749213-13744-1-git-send-email-geert+renesas@glider.be>
References: <1479749213-13744-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161123142322.GE9057@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 06:26:53PM +0100, Geert Uytterhoeven wrote:
> Add the device nodes for all MSIOF SPI controllers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested with MSIOF2(B) on EXIO connector D of r8a7796/salvator-x, using
> spidev, gpio-74x164, and a logic analyzer.

Thanks, I have queued this up for v4.11.
