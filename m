From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 09:33:51 +0100
Subject: Dropping device tree pinmux nodes for GPIO usage (Was: [PATCH
 3/5] arm64: dts: sun50i: add MMC nodes)
In-Reply-To: <20170115155931.l5tjcdhbz6sj3wke@localhost>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
 <20170115155931.l5tjcdhbz6sj3wke@localhost>
Message-ID: <20170117083351.jy7jsdpi2zvufq5q@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 15, 2017 at 04:59:32PM +0100, Rask Ingemann Lambertsen wrote:
> On Tue, Jan 03, 2017 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
> > On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > > +
> > > +                       mmc0_default_cd_pin: mmc0_cd_pin at 0 {
> > > +                               pins = "PF6";
> > > +                               function = "gpio_in";
> > > +                               bias-pull-up;
> > > +                       };
> > 
> > We are starting to drop pinmux nodes for gpio usage.
> 
> How do we get the equivalent of bias-pull-up/down and drive-strength if we
> run across a pin that needs it?

Hmm, that's actually a very good question...

For those cases, leave the pinctrl node for now, we'll deal with that
in due time

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/942b154f/attachment.sig>
