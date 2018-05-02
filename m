From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 2 May 2018 11:57:22 +0530
Subject: [PATCH 08/21] bindings: display: Add compatible for A64 HDMI PHY
In-Reply-To: <20180501161909.GA1728@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-9-jagan@amarulasolutions.com>
 <20180501161909.GA1728@rob-hp-laptop>
Message-ID: <CAMty3ZBBo41Odbife0WtPG__3qWaHZtkqUfOLTmqhzc_of+iYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, May 1, 2018 at 9:49 PM, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Apr 30, 2018 at 05:10:45PM +0530, Jagan Teki wrote:
> > HDMI PHY on Allwinner A64 has similar like H3/H5.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > index 9ea4353caadd..7dcd1d64dfe4 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -104,6 +104,7 @@ Required properties:
> >    - compatible: value must be one of:
> >      * allwinner,sun8i-a83t-hdmi-phy
> >      * allwinner,sun8i-h3-hdmi-phy
> > +    * allwinner,sun50i-a64-hdmi-phy
>
> This should be one valid combination per line. The dts shows that the h3
> string is a fallback which should be captured in the binding doc.

The fallback compatible "allwinner,sun8i-h3-hdmi-phy" is already
documented above, what we need to capture here? or did I miss anything
here?
