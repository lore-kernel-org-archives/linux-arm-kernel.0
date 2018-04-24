From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 14:14:28 +0200
Subject: [PATCH v2 1/2] arm: dts: sun8i: h3: libretech-all-h3-cc: Move
 board definition to common dtsi
In-Reply-To: <1524570434-17814-2-git-send-email-narmstrong@baylibre.com>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
 <1524570434-17814-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20180424121428.bd7zir646sl64t7t@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 01:47:13PM +0200, Neil Armstrong wrote:
> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move the
> content of the dts file to a common dtsi file to be included by the H3
> variant and in a following patch the H5 variant.
> 
> By the way, update the SPDX licence tag position.
> 
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/b6b68a39/attachment.sig>
