From: jic23@kernel.org (Jonathan Cameron)
Date: Fri, 30 Mar 2018 10:50:01 +0100
Subject: [PATCH 2/3] dt-bindings: iio: adc: document the Meson AXG support
In-Reply-To: <20180327150730.7ty6j76ym73vjth5@rob-hp-laptop>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-3-yixun.lan@amlogic.com>
 <20180327150730.7ty6j76ym73vjth5@rob-hp-laptop>
Message-ID: <20180330105001.5d9df535@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2018 10:07:30 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Mar 26, 2018 at 04:46:28PM +0800, Yixun Lan wrote:
> > From: Xingyu Chen <xingyu.chen@amlogic.com>
> > 
> > Update the documentation to expicitly support the Meson-AXG SoC.
> > 
> > Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore it ;)

Thanks,

Jonathan
