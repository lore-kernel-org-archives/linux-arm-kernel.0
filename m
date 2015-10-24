From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 24 Oct 2015 09:09:45 +0200
Subject: [PATCH v4 4/4] ARM: dts: sun6i: Add dts file for MSI Primo81
 tablet
In-Reply-To: <CAGb2v64xESxh0Dzsh9GijYZADbB-SM99ZVtu=9FGB2Gfz2-Z6Q@mail.gmail.com>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
 <1445572241-13259-5-git-send-email-wens@csie.org>
 <20151023145309.GA1885@excalibur.cnev.de>
 <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
 <CAGb2v64xESxh0Dzsh9GijYZADbB-SM99ZVtu=9FGB2Gfz2-Z6Q@mail.gmail.com>
Message-ID: <20151024070945.GP10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 23, 2015 at 11:56:35PM +0800, Chen-Yu Tsai wrote:
> >> as described in
> >> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> >> here, as the display is in portrait mode while the touchscreen is
> >> in landscape mode and needs to have the x and y axes swapped to
> >> work in the same coordinate system as the display.
> >>
> >> Regarding the driver side: the goodix driver in kernel 4.3
> >> doesn't yet support this property, but patches to add support for
> >> it are on the linux-input list and should hopefully make it into
> >> kernel 4.4.
> >
> > The DTS is already in Maxime's tree, and in sunxi-next. Feel free to
> > send a follow-up patch adding them. I was waiting for those patches
> > to be merged.
> 
> Sorry, spoke too soon. Maxime hasn't pushed it out yet. Could you send
> a patch adding touchscreen-swapped-x-y for Maxime to squash in?

I did the last DT pull request for 4.4 yesterday, so I won't squash
any patches.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151024/d45c62ae/attachment.sig>
