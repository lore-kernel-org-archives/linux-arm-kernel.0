From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jun 2016 22:52:23 +0200
Subject: [linux-sunxi] [PATCH] [V2] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <CAGb2v64PYU9H7Ag45ogwtjJAO87D6saTFv5-4P_E7d1xobQXXA@mail.gmail.com>
References: <20160602023623.5761-1-luoyi.ly@gmail.com>
 <CAGRGNgUiGaxoVxtq=k8NG5mCqEXS9fd-ry1vvVJfzb+R2ATMTA@mail.gmail.com>
 <20160602081638.GG4908@lukather> <574FF94B.3020309@web.de>
 <20160610093851.GQ5242@lukather>
 <CAGb2v64PYU9H7Ag45ogwtjJAO87D6saTFv5-4P_E7d1xobQXXA@mail.gmail.com>
Message-ID: <20160615205223.GC5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Jun 13, 2016 at 11:01:53AM +0800, Chen-Yu Tsai wrote:
> On Fri, Jun 10, 2016 at 5:38 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Jun 02, 2016 at 11:15:55AM +0200, Bernhard Nortmann wrote:
> >> Am 02.06.2016 um 10:16 schrieb Maxime Ripard:
> >> >[...]
> >> >Yes, everything that is shared with the banana-pro (which, judging
> >> >from Bernhard, is pretty much everything but a GPIO) should be merged
> >> >in the banapro DT.
> >> >
> >> >Maxime
> >> >
> >>
> >> Don't take my word for granted, as I do not own this hardware or know it
> >> particularly well. There is no doubt that "BPi-M1+" and "Banana Pro" are
> >> very similar, but if in doubt the information form the wiki should be
> >> verified.
> >
> > Hmmmm, ok. Chen-Yu, any input on this? You know the banana-pis much
> > more than I do.
> 
> I did a comparison of the "Banana Pro" vs the "BPi-M1+".
> 
> The differences are similar to what we have with any other development
> board, say the Cubietruck:
> 
>   - A different WiFi chip is used, and the BT part is not hooked up.
>   - Different GPIOs for external power regulator/switches
>   - Different GPIOs for LEDs
>   - Different peripherals exposed on the headers.
> 
> IMO There's no need to merge or have a common .dtsi for the two boards.

Ok.

> They (and all the other development boards) look similar because
> everyone is following the basic set by Allwinner's reference design,
> like which MMC controller and pins are used for SD/MMC, which ones
> are used for SDIO-based WiFi, and so on.
> 
> I did a version completely from scratch using just the schematics:
> 
>   https://github.com/wens/linux/commits/bpi-m1-plus

So, what do you mean by that? Do you have some comments on that patch,
or should I merge it, and you'll post your additions on top of it?

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/018a54a8/attachment.sig>
