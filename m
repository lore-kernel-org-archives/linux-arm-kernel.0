From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 14:56:11 +0200
Subject: [PATCH 2/2] arm64: dts: sunxi: Don't use cd-inverted in
 sun50i-a64-pinebook
In-Reply-To: <20180807232554.16825-2-tuomas@tuxera.com>
References: <20180807232554.16825-1-tuomas@tuxera.com>
 <20180807232554.16825-2-tuomas@tuxera.com>
Message-ID: <20180820125611.3txlxkxhzppfmztp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 02:25:54AM +0300, Tuomas Tynkkynen wrote:
> Another user of cd-inverted seems to have crept in. Switch it away from
> cd-inverted to be consistent with other sunxi boards.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Queued for 4.20, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/f13f5de6/attachment.sig>
