From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Jul 2016 17:40:11 +0200
Subject: [PATCH 1/2] ASoC: sunxi: Add bindings for sun6i to SPDIF
In-Reply-To: <CAEKpxBn6aC0o7nixq-gjCCwFkAy+sb-hE5DTp5ikm+4LaPfCzw@mail.gmail.com>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-2-codekipper@gmail.com>
 <20160730151724.GS6215@lukather>
 <CAEKpxBn6aC0o7nixq-gjCCwFkAy+sb-hE5DTp5ikm+4LaPfCzw@mail.gmail.com>
Message-ID: <20160730154011.GW6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 05:34:11PM +0200, Code Kipper wrote:
> On 30 July 2016 at 17:17, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Jul 30, 2016 at 04:27:15PM +0200, codekipper at gmail.com wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
> >> reset is controlled via a separate reset controller.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> >> index 13503aa..4fe80f7 100644
> >> --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> >> +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> >> @@ -9,6 +9,7 @@ Required properties:
> >>
> >>    - compatible               : should be one of the following:
> >>      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> >> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
> >>
> >>    - reg                      : Offset and length of the register set for the device.
> >>
> >> @@ -25,6 +26,8 @@ Required properties:
> >>       "apb"             clock for the spdif bus.
> >>       "spdif"           clock for spdif controller.
> >>
> >> +  - reset            : reset specifier for the ahb reset (A31 and newer only)
> >
> > Isn't it resets ? (plural)
> 
> Dohh..yes it is. Do you want me to send an updated patch series, a
> single patch change or could I beg for your commit massaging?

I'm not the one who is going to apply that patch, so I don't know :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/86b7715d/attachment.sig>
