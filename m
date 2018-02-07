From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 7 Feb 2018 20:43:06 +0800
Subject: [PATCH 2/2] dt-bindings: PCI: MediaTek: Correct the
 interrupt-map properties
In-Reply-To: <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
 <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
Message-ID: <1518007386.23115.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Mon, 2018-02-05 at 00:08 -0600, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 03:41:50PM +0800, Ryder Lee wrote:
> > Move the interrupt-map properties from the child nodes to the root node
> > and update each entry accordingly.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../devicetree/bindings/pci/mediatek-pcie.txt      | 28 ++++++++++++----------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Please ignore this patch as we think the original version is better than
this.  Sorry for the inconvenience.

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
