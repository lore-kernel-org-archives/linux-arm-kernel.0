From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 15 Jan 2017 16:59:32 +0100
Subject: Dropping device tree pinmux nodes for GPIO usage (Was: [PATCH 3/5]
 arm64: dts: sun50i: add MMC nodes)
In-Reply-To: <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
Message-ID: <20170115155931.l5tjcdhbz6sj3wke@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > +
> > +                       mmc0_default_cd_pin: mmc0_cd_pin at 0 {
> > +                               pins = "PF6";
> > +                               function = "gpio_in";
> > +                               bias-pull-up;
> > +                       };
> 
> We are starting to drop pinmux nodes for gpio usage.

How do we get the equivalent of bias-pull-up/down and drive-strength if we
run across a pin that needs it?

-- 
Rask Ingemann Lambertsen
