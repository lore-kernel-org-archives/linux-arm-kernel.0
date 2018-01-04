From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 16:03:52 +0100
Subject: [PATCH 1/2] ARM: dts: sunxi: Switch MMC nodes away from
 cd-inverted property
In-Reply-To: <20171222205738.2389-1-tuomas@tuxera.com>
References: <20171222205738.2389-1-tuomas@tuxera.com>
Message-ID: <20180104150352.rsvtvviafxyuq2jp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 10:57:37PM +0200, Tuomas Tynkkynen wrote:
> Using the cd-inverted property is not useful when GPIOs are used as card
> detects since the polarity can be specified with the usual
> GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
> U-Boot developers, so migrate all sunxi boards away from cd-inverted.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/e901dee6/attachment.sig>
