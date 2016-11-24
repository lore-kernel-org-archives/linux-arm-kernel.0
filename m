From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 22:30:11 +0100
Subject: [PATCH 3/3] ARM: dts: sunxi: enable SDIO Wi-Fi on Orange Pi Zero
In-Reply-To: <CAGb2v64taF9x9MDYW+KUEEUUoSx0bF68QNc7uZXQoNrsozMGtg@mail.gmail.com>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-3-icenowy@aosc.xyz>
 <20161123075950.fjtplylunwale6j4@lukather>
 <CAGb2v64taF9x9MDYW+KUEEUUoSx0bF68QNc7uZXQoNrsozMGtg@mail.gmail.com>
Message-ID: <20161124213011.vyyfr6ikhgt3xath@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 10:25:57PM +0800, Chen-Yu Tsai wrote:
> >>  &r_pio {
> >> @@ -111,6 +148,11 @@
> >>               pins = "PL10";
> >>               function = "gpio_out";
> >>       };
> >> +
> >> +     wifi_pwrseq_pin_opi0: wifi_pwrseq_pin at 0 {
> >> +             allwinner,pins = "PL7";
> >> +             allwinner,function = "gpio_out";
> >
> > And same thing here.
> 
> Might we do away with the pinmux for gpio pins tradition?
> Recent patches I've sent all omit them.

Oh, yes, that's true.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/836dbe90/attachment.sig>
