From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Oct 2017 14:36:32 +0200
Subject: [PATCH 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from
 dts to dtsi
In-Reply-To: <20171022091957.24614-2-joonas.kylmala@iki.fi>
References: <20171022091957.24614-1-joonas.kylmala@iki.fi>
 <20171022091957.24614-2-joonas.kylmala@iki.fi>
Message-ID: <20171025123632.3jfjcztztm2qowrp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 22, 2017 at 12:19:56PM +0300, Joonas Kylm?l? wrote:
> Most of the boards use the mmc0 pins and their attributes defined in
> mmc0_pins_a and mmc0_cd_pin. Let's default to those by moving the
> pinctrl attributes to the dtsi file. This makes it easier to modify
> device trees in the future as there is only one place to change the
> pinctrl attributes.
> 
> As a side effect this patch also adds the detect pin of Orange Pi
> Zero's mmc0 under pinctrl as it should have been there right from the
> beginning.

We're actually in the process of removing those gpio pinctrl
nodes. Could you make that while you're at it?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171025/66ef3291/attachment.sig>
