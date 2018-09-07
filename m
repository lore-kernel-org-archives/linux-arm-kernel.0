From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 10:21:22 +0200
Subject: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
In-Reply-To: <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
 <20180905075056.tob7itg3judccooe@flea>
 <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
Message-ID: <20180907082122.bcylf2jpf6eq6dgq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 09:43:29AM +0530, Jagan Teki wrote:
> On Wed, Sep 5, 2018 at 1:20 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Tue, Sep 04, 2018 at 12:40:50PM +0800, Icenowy Zheng wrote:
> >> +             hdmi_phy: hdmi-phy at 1ef0000 {
> >> +                     compatible = "allwinner,sun8i-h3-hdmi-phy";
> >> +                     reg = <0x01ef0000 0x10000>;
> >> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> >> +                              <&ccu 7>;
> >> +                     clock-names = "bus", "mod", "pll-0";
> >> +                     resets = <&ccu RST_BUS_HDMI0>;
> >> +                     reset-names = "phy";
> >> +                     #phy-cells = <0>;
> >> +             };
> >
> > This needs to use the bindings we have for that phy.
> 
> You mean allwinner,sun50i-a64-hdmi-phy ?

Yes

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/c8e4f324/attachment.sig>
