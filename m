From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 12:17:42 +0200
Subject: [PATCH 0/3] arm64: dts: allwinner: h5: Add device tree for
 Bananapi M2 Plus H5
In-Reply-To: <20180830080926.15027-1-wens@csie.org>
References: <20180830080926.15027-1-wens@csie.org>
Message-ID: <20180831101742.3ybvf6d3refft454@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 04:09:23PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> Allwinner's H5 SoC is pin compatible with the H3 SoC. As such, some
> vendors produce H3 and H5 variants for the same device. Such is the
> case with Libre Computer's ALL-H3-CC, and the Bananapi M2 Plus.
> 
> This series follows that of the ALL-H3-CC, splitting out a common
> board dtsi, and then two SoC-specific dts files that include the
> SoC level and common board dtsi's, as well as putting in the board
> name. The first patch is a minor fix that I think should be done
> before the migration.
> 
> Please have a look.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> Also, on a related matter, Bananapi recently released revision v1.2
> of the M2 Plus. The original commercially available version was v1.1.
> v1.2 adds a GPIO control that can change the CPU cores' supply voltage
> between 1.1V and 1.3V. Do we want two extra dts files for this? Put
> them in the existing dts files regardless? Or let people handle this
> via overlays?

If that the sole change, I'd be inclined to merge it as a separate DT
for that particular version. Is there any way to detect it at runtime?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/fcbc7140/attachment.sig>
