From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 14:41:19 +0200
Subject: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
In-Reply-To: <20180724163655.61365-1-icenowy@aosc.io>
References: <20180724163655.61365-1-icenowy@aosc.io>
Message-ID: <20180726124119.dwne2sncws2p3sdi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> Banana Pi designs the BPi M2 Berry board to be software compatible with
> BPi M2 Ultra,

Do you have a reference for this?

> so it's based on M2 Ultra with some function cuts, including:
> 
> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
> - dropped a LED;
> - dropped eMMC;
> - dropped USB2 and connect USB1 to a 4-port HUB.

Is it the exhaustive list?

I'm a bit reluctant to merge that kind of patches usually, since that
would also imply that each time someone will commit something to the
M2-Ultra, it would automatically apply to the M2-Berry, without any
easy way to tell and / or test.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/9b74e0d7/attachment.sig>
