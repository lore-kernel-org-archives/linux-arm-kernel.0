From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Mar 2016 19:52:43 +0100
Subject: [linux-sunxi][PATCH 3/5] ARM: dts: sunxi: Add the SPDIF to the
 A10 and A20
In-Reply-To: <CAEKpxBm4bs7sNSbDjomdP6XS2ApvfDT-s942DBb3JWv1iOZJ0w@mail.gmail.com>
References: <1456589909-2428-1-git-send-email-codekipper@gmail.com>
 <1456589909-2428-4-git-send-email-codekipper@gmail.com>
 <20160313215043.GJ8418@lukather>
 <CAEKpxBm4bs7sNSbDjomdP6XS2ApvfDT-s942DBb3JWv1iOZJ0w@mail.gmail.com>
Message-ID: <20160314185243.GE30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 05:29:37PM +0100, Code Kipper wrote:
> >> +             spdif: spdif at 01c21000 {
> >> +                     #sound-dai-cells = <0>;
> >> +                     compatible = "allwinner,sun4i-a10-spdif";
> >> +                     reg = <0x01c21000 0x40>;
> >
> > It only takes 64 bytes?
>
> Yep(just like the audio codec!)
> http://linux-sunxi.org/SPDIF#SUNXI_SPDIF_DEFAULT_VALUES

Yet the datasheet says it takes 1k in the memory map.

Please use that value instead.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/8ce1a327/attachment.sig>
