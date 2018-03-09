From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 9 Mar 2018 10:10:38 +0100
Subject: [PATCH] arm: dts: nes: add Nintendo NES Classic Edition support
In-Reply-To: <20180309095814.5ea40afe@xps13>
References: <20180307164336.32359-1-miquel.raynal@bootlin.com>
 <20180309082656.kglipdyu3knfq4ga@flea.lan>
 <20180309095814.5ea40afe@xps13>
Message-ID: <20180309091038.6jxuymerx5lgnh3y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 09:58:14AM +0100, Miquel Raynal wrote:
> > Since you tested on a SuperNES Classic, I think you should also create
> > a new DT (possibly include it) with a compatible of its own.
> > 
> > That way, if we ever find some differences, it will be easy to deal
> > with them.
> 
> So, what you would prefer is:
> 1/ Move this entire DTS but the usb_otg node into a
> "sun8i-r16-nintendo-nes.dtsi"
> 2/ Include that DTSI from a
> "sun8i-r16-nintendo-super-nes-classic-edition.dts" that would add the
> usb_otg node as it is above.

My remark had nothing to do with USB OTG. You can just create a DT
called sun8i-r16-nintendo-nes-classic.dts, and then create another one
call sun8i-r16-nintendo-supernes-classic.dts that would include the
former, only overriding the compatible.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/8a22240d/attachment-0001.sig>
