From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 May 2017 07:53:50 -0700
Subject: [PATCH v2 1/2] Documentation: dt: Update ti,emif bindings
In-Reply-To: <20170520014554.qisnvr27542n5p7f@rob-hp-laptop>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-2-d-gerlach@ti.com>
 <20170520014554.qisnvr27542n5p7f@rob-hp-laptop>
Message-ID: <20170522145350.GP10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [170519 18:49]:
> On Fri, May 19, 2017 at 12:57:07PM -0500, Dave Gerlach wrote:
> > Update the Texas Instruments EMIF binding document to include the device
> > tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
> > the ti-emif-sram driver to provide low-level PM functionality.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > ---
> >  .../devicetree/bindings/memory-controllers/ti/emif.txt | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> I acked v1. Please add acks when posting new versions.

And if I did not do so already:

Acked-by: Tony Lindgren <tony@atomide.com>
