From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 11:48:42 +0100
Subject: [PATCH] arm64: renesas: document V3MSK board bindings
In-Reply-To: <20171126222905.62qkvnvep2rkqcb6@rob-hp-laptop>
References: <20171124204748.920422106@cogentembedded.com>
 <20171126222905.62qkvnvep2rkqcb6@rob-hp-laptop>
Message-ID: <20171129104842.qdr6rwyw6ocdf7pl@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 26, 2017 at 04:29:05PM -0600, Rob Herring wrote:
> On Fri, Nov 24, 2017 at 11:47:39PM +0300, Sergei Shtylyov wrote:
> > Document the V3M Starter Kit device tree bindings, listing it as
> > a supported board.
> > 
> > This allows to use checkpatch.pl to validate .dts files referring to
> > the V3MSK board.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> >  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied.
