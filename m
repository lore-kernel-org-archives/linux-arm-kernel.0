From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:22:41 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: Enable audio
 codec
In-Reply-To: <20181126055946.20344-1-wens@csie.org>
References: <20181126055946.20344-1-wens@csie.org>
Message-ID: <20181127082241.jx3vzapy5mlgfabc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 01:59:46PM +0800, Chen-Yu Tsai wrote:
> This patch enables audio via the SoC's internal audio codec. All
> relevant device nodes are enabled, and the routing is set to match
> the board design. MIC1 is routed to an onboard microphone, with MBIAS
> providing power. MIC2 and HP are routed to the 3.5mm headset TRRS jack.
> No phantom power is provided to the headset microphone.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/2f4f6376/attachment.sig>
