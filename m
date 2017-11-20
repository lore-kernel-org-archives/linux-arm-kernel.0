From: horms@verge.net.au (Simon Horman)
Date: Mon, 20 Nov 2017 10:48:41 +0100
Subject: [PATCH v2] arm64: dts: renesas: salvator-common: Add BD9571 PMIC
In-Reply-To: <1510839250-11199-1-git-send-email-geert+renesas@glider.be>
References: <1510839250-11199-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20171120094840.l2egl4w25fzpmlq2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 02:34:10PM +0100, Geert Uytterhoeven wrote:
> Add a device node for the ROHM BD9571MWV PMIC.
> 
> This was based on the example in the DT binding documentation, but using
> IRQ0 instead of a GPIO interrupt, as that matches the schematics, and
> because INTC-EX is a simpler block.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Clarify the choice for INTC-EX.

Thanks, applied.
