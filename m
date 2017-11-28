From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 16:47:34 +0100
Subject: [PATCH v2] sunxi-rsb: Include OF based modalias in device uevent
In-Reply-To: <53cb17f5-6077-419a-8e5c-6c80f9dfa9dc@rwthex-w2-a.rwth-ad.de>
References: <53cb17f5-6077-419a-8e5c-6c80f9dfa9dc@rwthex-w2-a.rwth-ad.de>
Message-ID: <20171128154734.v2yog6lwiombv3io@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 08:05:34PM +0100, Stefan Br?ns wrote:
> Include the OF-based modalias in the uevent sent when registering devices
> on the sunxi RSB bus, so that user space has a chance to autoload the
> kernel module for the device.
> 
> Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
> pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
> the AXP803 PMIC is built as a module, it is not loaded and the system
> ends up with an disfunctional MMC controller.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/d025d6a0/attachment.sig>
