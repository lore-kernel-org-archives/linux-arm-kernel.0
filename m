From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Aug 2014 17:15:07 +0100
Subject: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
In-Reply-To: <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
 <20140817144201.GB29963@gmail.com>
 <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
Message-ID: <20140818161507.GC3302@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 04:21:23PM +0100, Carlo Caione wrote:
> On Sun, Aug 17, 2014 at 4:42 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> > Hi,
> 
> >> +/include/ "meson.dtsi"
> >> +
> >> +/ {
> >> +     model = "Amlogic Meson6 SoC";
> >> +     compatible = "amlogic,meson6", "amlogic,8726_mx";
> >> +
> >> +     interrupt-parent = <&gic>;
> >> +
> >> +     cpus {
> >> +             #address-cells = <1>;
> >> +             #size-cells = <0>;
> >> +
> >> +             cpu at 0 {
> >
> > The address after the @ should match the value of the 'reg' property.

Just remember to strip the leading "0x" (this should be "cpu at 200").

Cheers,
Mark.
