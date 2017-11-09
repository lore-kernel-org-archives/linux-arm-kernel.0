From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Nov 2017 13:15:28 +0100
Subject: [linux-sunxi] Re: [PATCH v2 00/10] Allwinner H3/H5/A64(DE2)
 SimpleFB support
In-Reply-To: <CAP03XerMhdOYL08ED7=rt99BZ=RpXLhz_EySUhrJ4HbjYTX93g@mail.gmail.com>
References: <20171027150658.18509-1-icenowy@aosc.io>
 <9bca10cc95d04f87a1122bc582402310@aosc.io>
 <20171102154447.b5qo3rvu5djxupay@flea>
 <20171106084043.2vv56w2dmrutz4gn@phenom.ffwll.local>
 <CAP03XerMhdOYL08ED7=rt99BZ=RpXLhz_EySUhrJ4HbjYTX93g@mail.gmail.com>
Message-ID: <20171109121528.zqilrabirceyaj5h@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 11:17:03AM +0000, Chris Obbard wrote:
> Hi Everyone,
> 
> What's the status of HDMI/SimpleFB driver for H5?
> 
> I don't see anything related to HDMI in linux-next dts files:
> 
> arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts? (example board)
> arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> arch/arm/boot/dts/sunxi-h3-h5.dtsi

It will be part of 4.16 and are not in linux-next (yet).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/fe25db37/attachment-0001.sig>
