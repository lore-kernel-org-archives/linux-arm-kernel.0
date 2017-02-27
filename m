From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 15:40:57 +0100
Subject: [PATCH 8/8] ARM: sun8i: a33: Add the Mali OPPs
In-Reply-To: <20170215234029.3vfh25gxtvz44dsw@rob-hp-laptop>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <2e4a4f3f2f584f65f3c2d5e78f589015c651198d.1486655917.git-series.maxime.ripard@free-electrons.com>
 <20170215234029.3vfh25gxtvz44dsw@rob-hp-laptop>
Message-ID: <20170227144057.in7uclundvd77s5q@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 05:40:29PM -0600, Rob Herring wrote:
> On Thu, Feb 09, 2017 at 05:39:22PM +0100, Maxime Ripard wrote:
> > The Mali GPU in the A33 has various operating frequencies used in the
> > Allwinner BSP.
> > 
> > Add them to our DT.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a33.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> > index 043b1b017276..e1b0abfee42f 100644
> > --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> > @@ -101,6 +101,22 @@
> >  		status = "disabled";
> >  	};
> >  
> > +	mali_opp_table: opp_table1 {
> 
> gpu-opp-table

Applied with that change. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/fbd5b1a5/attachment.sig>
