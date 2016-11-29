From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Nov 2016 22:43:23 +0100
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: sun8i: add simplefb node
 for H3
In-Reply-To: <CAGb2v66yQ2d=12P_MYyQXTfcZnNAMcb+0i=NEab4sNcJZUyL-w@mail.gmail.com>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
 <CAGb2v67akcT6z-xOdCzpLQRZbgNGh3E5akYEs1BvFNP1rH8UeA@mail.gmail.com>
 <496171480328390@web15g.yandex.ru>
 <CAGb2v66yQ2d=12P_MYyQXTfcZnNAMcb+0i=NEab4sNcJZUyL-w@mail.gmail.com>
Message-ID: <20161129214323.rsi7xyghffrkwyjd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 06:24:24PM +0800, Chen-Yu Tsai wrote:
> On Mon, Nov 28, 2016 at 6:19 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> >
> >
> > 28.11.2016, 18:07, "Chen-Yu Tsai" <wens@csie.org>:
> >> On Mon, Nov 28, 2016 at 5:59 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> >>>  As there's currently a fork of U-Boot which provides simplefb support
> >>
> >> Please add it when its finalized...
> >>
> >>>  for H3, a simplefb node can be added to the device tree.
> >>>
> >>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >>>  ---
> >>>
> >>>  I'm still not sure which pipeline should I use.
> >>
> >> You are supposed to add _all_ the pipelines that are available and
> >> supported by U-boot. U-boot is then supposed to enable and update
> >> the one it set up.
> >
> > I mean the pipeline string ;-)
> 
> Looks good to me. There's no separate frontend/backend in DE 2.0.

It looks good to me too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161129/5cd26f51/attachment.sig>
