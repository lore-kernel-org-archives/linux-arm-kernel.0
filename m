From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Nov 2018 16:06:58 +0100
Subject: [PATCH] arm64: dts: allwinner: h6: fix EMAC compatible string
 sequence
In-Reply-To: <20181115031551.11756-1-icenowy@aosc.io>
References: <20181115031551.11756-1-icenowy@aosc.io>
Message-ID: <20181115150658.ctlapreik2alvmwl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:15:51AM +0800, Icenowy Zheng wrote:
> The SoC-specific compatible should come before the fallback compatible
> string when multiple compatible strings are present, but the sequence is
> wrong currently on H6 EMAC node (A64 fallback before H6 compatible).
> 
> Fix the sequence.
> 
> Fixes: c8ced5516d23 ("arm64: allwinner: h6: add EMAC device nodes")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/aa81c0f8/attachment.sig>
