From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 13 Jul 2018 10:28:17 +0200
Subject: [PATCH v5 20/22] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <20180710092310.2hzoc7shmfykr3n5@flea>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-21-paul.kocialkowski@bootlin.com>
 <20180710092310.2hzoc7shmfykr3n5@flea>
Message-ID: <d9cc498c058b34b46eaf910de2f6ba4dd4ca4838.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-07-10 at 11:23 +0200, Maxime Ripard wrote:
> On Tue, Jul 10, 2018 at 10:01:12AM +0200, Paul Kocialkowski wrote:
> > +		vpu: video-codec at 1c0e000 {
> > +			compatible = "allwinner,sun7i-a20-video-engine";
> > +			reg = <0x01c0e000 0x1000>;
> > +
> 
> The issue is here with all your patches, but you should drop the node
> label and the extra new line.

Noted, this will be fixed in the next revision.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180713/fd3f168d/attachment.sig>
