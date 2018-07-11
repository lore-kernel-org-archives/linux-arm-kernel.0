From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 10:24:34 +0200
Subject: [PATCH] ARM: dts: sun8i: sun8i-a83t-bananapi-m3: enhance vcc-pd
 to 3.3v
In-Reply-To: <1531165914-29760-1-git-send-email-clabbe@baylibre.com>
References: <1531165914-29760-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180711082434.euhakdczf56p3fia@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 07:51:54PM +0000, Corentin Labbe wrote:
> Since commit d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes")
> my BPIM3 no longer works at gigabit speed.
> 
> With the default setting, dldo3 is regulated at 2.9v which seems
> sufficient for the PHy but d7c5f6863550 drop it to 2.5 which is insufficient.
> Note that this behaviour is random for all BPIM3 (some works with 2.5, some not)
> 
> Finnaly, someone from bananapi confirmed that this regulator must be set to 3.3
> 
> Fixes: d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/85b79419/attachment.sig>
