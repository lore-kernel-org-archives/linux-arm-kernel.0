From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 10 Jul 2018 11:23:10 +0200
Subject: [PATCH v5 20/22] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <20180710080114.31469-21-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-21-paul.kocialkowski@bootlin.com>
Message-ID: <20180710092310.2hzoc7shmfykr3n5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:01:12AM +0200, Paul Kocialkowski wrote:
> +		vpu: video-codec at 1c0e000 {
> +			compatible = "allwinner,sun7i-a20-video-engine";
> +			reg = <0x01c0e000 0x1000>;
> +

The issue is here with all your patches, but you should drop the node
label and the extra new line.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/889d9f7c/attachment.sig>
