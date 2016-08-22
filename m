From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 15:36:14 +0200
Subject: [PATCH v2 0/4] Add AXP209 GPIO driver
In-Reply-To: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
References: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
Message-ID: <20160822133614.GN7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 04:11:35PM +0200, Maxime Ripard wrote:
> Hi,
> 
> The axp209 PMIC used in combination to some Allwinner SoCs has a bunch
> of GPIOs accessible. Some boards use these to control their backlight
> or a few LEDs.
> 
> There's supposed to be 4 of them, but the fourth one has a different
> configuration register scheme, and I couldn't find any board that was
> using this GPIO. It will be probably be supported eventually, but
> until then, we support only the first 3 GPIOs.

I merged the patches 3 and 4.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/303fe1f7/attachment-0001.sig>
