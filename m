From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 11:59:14 +0200
Subject: [PATCH 2/2] ARM64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
In-Reply-To: <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20180424095914.cs362x4zdwxzo6ru@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 24, 2018 at 11:19:36AM +0200, Neil Armstrong wrote:
> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
> Pi B+ form factor single board computer based on the Allwinner H2+, H3, or H5
> SoCs with the same PCB.
> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
> and connectors are in the exact same position as on the Raspberry Pi B+.
> 
> This patch enables the H5 variant using the H3 board definition moved to
> a common dtsi in an earlier patch. The dts simply include the common dtsi
> and declares the correct compatible and model of the H5 variant.
> 
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

prefix should be "arm64: dts: allwinner"

You had this issue with the first patch as well, your commit log
should be wrapped, checkpatch complains at the moment.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/df807284/attachment.sig>
