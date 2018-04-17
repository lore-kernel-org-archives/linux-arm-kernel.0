From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 11:18:16 +0200
Subject: [PATCH] ARM: dts: sun8i: h3: Re-enable EMAC on Orange Pi One
In-Reply-To: <20180417041714.27266-1-wens@csie.org>
References: <20180417041714.27266-1-wens@csie.org>
Message-ID: <20180417091816.xcda7q6gugyqj3ie@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 12:17:14PM +0800, Chen-Yu Tsai wrote:
> In commit f0842bc5637c ("ARM: dts: sun8i: h3: Enable HDMI output on H3
> boards"), the hunk that enabled HDMI for the Orange Pi One did not add a
> 
>     status = "okay";
> 
> line for the HDMI node, inadvertenly using the one for the EMAC. This
> resulted in the EMAC now being disabled. Whether this was due to a
> rebase error or some other mishap is unknown.
> 
> This patch re-enables the EMAC by adding the status line to its node.
> 
> Fixes: f0842bc5637c ("ARM: dts: sun8i: h3: Enable HDMI output on H3 boards")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/5cc91314/attachment.sig>
