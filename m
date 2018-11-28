From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:17:47 +0100
Subject: [PATCH 01/15] dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs
 as a list
In-Reply-To: <20181128093013.24442-2-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-2-wens@csie.org>
Message-ID: <20181128101747.t2lcgesulh2rkwyi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 05:29:58PM +0800, Chen-Yu Tsai wrote:
> The clock output section for this binding describes the two outputs in
> the descriptions for both the #clock-cells and clock-output-names
> properties.
> 
> Instead of overlapping information that is hard to read, rewrite the
> clock outputs as a list of indices and descriptions. The properies
> can reference this list instead. This will also make it easier to
> add notes or conditions to the clocks, and also for adding new outputs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/bf20655f/attachment.sig>
