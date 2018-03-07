From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Mar 2018 08:44:25 +0100
Subject: [PATCH 2/5] pwm: sun4i: simplify controller mapping
In-Reply-To: <20180307020719.6675-3-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-3-andre.przywara@arm.com>
Message-ID: <20180307074425.72s4zufhesxh3i6r@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 02:07:16AM +0000, Andre Przywara wrote:
> At the moment we assign our supported compatible strings to a respective
> instance of our sun4i_pwm_data structure, even though some of them
> are the same.
> To avoid further clutter, split out the three different combinations of
> features we have at the moment and name them accordingly.
> This should make it more obvious which compatible string to use for new
> SoCs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/f97cfeaf/attachment.sig>
