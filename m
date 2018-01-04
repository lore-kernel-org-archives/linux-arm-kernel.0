From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 16:04:10 +0100
Subject: [PATCH 2/2] arm64: dts: sunxi: Switch MMC nodes away from
 cd-inverted property
In-Reply-To: <20171222205738.2389-2-tuomas@tuxera.com>
References: <20171222205738.2389-1-tuomas@tuxera.com>
 <20171222205738.2389-2-tuomas@tuxera.com>
Message-ID: <20180104150410.c2m2p4suca66chko@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 10:57:38PM +0200, Tuomas Tynkkynen wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/4ed5a34e/attachment.sig>
