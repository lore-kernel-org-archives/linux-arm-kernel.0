From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Oct 2016 11:04:12 +0200
Subject: [PATCH 6/9] dt-bindings: pinctrl: Deprecate sunxi pinctrl bindings
In-Reply-To: <CAGb2v67wk_DANTyzaxTM6Stgh-u2kZXn_kjb0vbWDYUd-DUxGA@mail.gmail.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <fad5a977d8ecdd43b37d7028b1bc32d8667b65a2.1475489558.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67wk_DANTyzaxTM6Stgh-u2kZXn_kjb0vbWDYUd-DUxGA@mail.gmail.com>
Message-ID: <20161007090412.GM4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 10:32:12AM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The generic pin configuration and multiplexing should be preferred now,
> > even though we still support the old one.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 5 +++++
> >  1 file changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> > index 69617220c5d6..e8b7cf64fdf1 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> > @@ -36,6 +36,11 @@ pins it needs, and how they should be configured, with regard to muxer
> >  configuration, drive strength and pullups. If one of these options is
> >  not set, its actual value will be unspecified.
> >
> > +This driver supports the generic pin multiplexing and configuration
> > +bindings.
> 
> Should we list which options are supported? We don't support them all.

Yep, I'll add that.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/f1ab6c83/attachment.sig>
