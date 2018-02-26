From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 26 Feb 2018 17:27:52 +0100
Subject: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
In-Reply-To: <4AA78C45-E139-417E-BE89-FE0BFBC409B0@aosc.io>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <2676311.2IEVhXnSIE@jernej-laptop>
 <4AA78C45-E139-417E-BE89-FE0BFBC409B0@aosc.io>
Message-ID: <2342395.9m6rrqTry7@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ponedeljek, 26. februar 2018 ob 17:21:05 CET je Icenowy Zheng napisal(a):
> ? 2018?2?27? GMT+08:00 ??12:16:44, "Jernej ?krabec" 
<jernej.skrabec@siol.net> ??:
> >Hi Julian,
> >
> >Dne nedelja, 25. februar 2018 ob 09:11:34 CET je Julian Calaby
> >
> >napisal(a):
> >> Hi Jernej,
> >> 
> >> On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
> >
> ><jernej.skrabec@siol.net>
> >
> >wrote:
> >> > Enable HDMI output on all boards which have HDMI connector.
> >> > 
> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > ---
> >> > 
> >> >  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> >> >  
> >> >   | 25 ++++++++++++++++++++++
> >> >  
> >> >  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
> >> >  
> >> >   | 25 ++++++++++++++++++++++
> >
> >arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> >
> >> >         | 25 ++++++++++++++++++++++
> >> >  
> >> >  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> >> >  
> >> >   | 24 +++++++++++++++++++++
> >
> >arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> >
> >> >        | 25 ++++++++++++++++++++++ 8 files changed, 199
> >
> >insertions(+)
> >
> >> As I understand it, the H2+ is just a slightly trimmed down H3. In
> >> terms of HDMI support, the difference is that the H2+ can't output
> >
> >4k.
> >
> >> If this code is compatible with the H2+, could you please add the
> >> necessary bits and pieces to the h2-plus DTSs too?
> >
> >There are only 3 H2+ boards in kernel and none of them has HDMI
> >connector, so
> 
> BPi M2 Zero has miniHDMI connector.

Ah, sorry, I missed that one. Since I don't have it (or any other board with 
H2+) I'm not really comfortable including such patch. If anyone will test it, 
I can include it in next revision.

Best regards,
Jernej

> 
> >there's nothing to do actually. But if such board is added to kernel,
> >it would
> >be trivially add proper nodes, since all H2+ boards include H3 DTSI.
> >
> >Best regards,
> >Jernej
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
