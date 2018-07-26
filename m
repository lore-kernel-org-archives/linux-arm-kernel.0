From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:43:02 +0200
Subject: [PATCH v2 11/18] arm64: dts: allwinner: a64: Orange Pi Win: Add
 missing power rails
In-Reply-To: <20180726003532.18751-12-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-12-andre.przywara@arm.com>
Message-ID: <20180726074302.c53cprwxweakykok@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:35:25AM +0100, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> The Orange Pi Win board has some of the AXP's power rails connected
> on the board. Name them and adjust the voltage ranges.

They are already named, so you'd need to explain why that name needs
to be changed.

Same thing for the voltage range, a citation would be useful.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/3f66814b/attachment.sig>
