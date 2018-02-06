From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 6 Feb 2018 09:29:08 +0100
Subject: [linux-sunxi] [PATCH v3] ARM: sun8i: h2+: add support for Banana
 Pi M2 Zero board
In-Reply-To: <A0E61415-4A64-41E5-94F2-3161D2B7A191@aosc.io>
References: <20171224054029.12278-1-icenowy@aosc.io>
 <CAGRGNgXRhphuO8+85t8vfQb2CxDekMXe2BoPo_57pc6SR3QQzA@mail.gmail.com>
 <20180205133625.vcz73qck5kfihalv@flea>
 <A0E61415-4A64-41E5-94F2-3161D2B7A191@aosc.io>
Message-ID: <20180206082908.jlmnsicnhpgankwf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 10:51:04AM +0800, Icenowy Zheng wrote:
> ? 2018?2?5? GMT+08:00 ??9:36:25, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >On Sat, Feb 03, 2018 at 05:45:52PM +1100, Julian Calaby wrote:
> >> Hi all,
> >> 
> >> On Sun, Dec 24, 2017 at 4:40 PM, Icenowy Zheng <icenowy@aosc.io>
> >wrote:
> >> > Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a
> >form
> >> > factor and GPIO holes similar to Raspberry Pi Zero.
> >> >
> >> > It features:
> >> > - Allwinner H2+ SoC
> >> > - Single-chip (16-bit) 512MiB DDR3 DRAM
> >> > - Ampak AP6212 Wi-Fi/Bluetooth module
> >> > - MicroSD slot
> >> > - Two MicroUSB Type-B ports (one can only be used to power the
> >board and
> >> >   the other features OTG functionality)
> >> > - Two keys, a reset and a GPIO-connected key.
> >> > - HDMI Type-C (miniHDMI) connector connected to the HDMI part of
> >H2+.
> >> > - CSI connector to connect the camera sensor provided by Sinovoip.
> >> >
> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> 
> >> [Trimmed lots of non-sunxi-specific mailing lists]
> >> 
> >> Did support for this board ever get merged?
> >
> >It doesn't look like it did.
> 
> Is there any problem in this patch now except the
> absense of SPDX license usage?

Doesn't look like it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180206/7504aa8c/attachment.sig>
