From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 17:44:13 -0500
Subject: [PATCH 1/3] clk: meson: meson8b: add compatibles for Meson8 and
 Meson8m2
In-Reply-To: <1496651008.3552.24.camel@baylibre.com>
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
 <20170604183341.21417-2-martin.blumenstingl@googlemail.com>
 <1496606325.3552.16.camel@baylibre.com>
 <CAFBinCCLL5ZqiZzWi-RsfZ-5_h20O5LRRY3+K7dt=U4qrveQ_w@mail.gmail.com>
 <1496651008.3552.24.camel@baylibre.com>
Message-ID: <20170608224413.fdv4xlvnjld4bgtz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 10:23:28AM +0200, Jerome Brunet wrote:
> On Mon, 2017-06-05 at 00:27 +0200, Martin Blumenstingl wrote:
> > > I think you should split the binding documentation and clk changes into
> > > separate
> > > patches.
> > 
> > OK, from what I know is that for "trivial" changes the driver and
> > dt-binding changes can go through one patch.
> > this patch started as a four-line patch which added two lines of
> > documentation and two lines of driver code.
> 
> I'm not aware of such tolerance but if you've have seen that the DT maintainers
> are OK with it, feel free to point me to it.
> 
> Last time I heard about it, DT guys were using filter-branch on the kernel tree
> to create a separate tree, so I was thinking that this "documentation as a
> separate patch" was a hard rule ... but I may be wrong

That is one of the reasons, but there is no hard rule. It's not worth a 
respin just for that either.

Acked-by: Rob Herring <robh@kernel.org>
