From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 May 2017 21:23:58 +0200
Subject: [linux-sunxi] [PATCH v2 20/20] ARM: sun5i: a10s-olinuxino:
 Enable HDMI
In-Reply-To: <CAGb2v65S2pw3z8NZ+tkPkF=A=5z2toRkC+26pAs6La6CNyeXoQ@mail.gmail.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <c7ac6faa0568e6418291255af537c4b070bdea63.1493812478.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65S2pw3z8NZ+tkPkF=A=5z2toRkC+26pAs6La6CNyeXoQ@mail.gmail.com>
Message-ID: <20170510192358.taufs5tsyifueued@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 04, 2017 at 04:05:18PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A10s Olinuxino has an HDMI connector. Make sure we can use it.
> >
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 29 +++++++++++++++++-
> >  1 file changed, 29 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> > index 894f874a5beb..1d13b6407222 100644
> > --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> > +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> > @@ -63,6 +63,17 @@
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       connector {
> > +               compatible = "hdmi-connector";
> > +               type = "a";
> 
> Just curious, should we take this into consideration when creating
> drm_connector?

I'm not sure, no other driver does so. And I haven't seen any of our
boards with a HDMI-B, C or mini-HDMI connector.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170510/17e0817b/attachment.sig>
