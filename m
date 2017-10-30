From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 30 Oct 2017 22:51:52 +0800
Subject: [PATCH v4 1/2] dt-bindings: add bindings doc for hi3798cv200
 combphy
In-Reply-To: <20171027142606.zilypg7tuxwy3fj2@rob-hp-laptop>
References: <1509073651-23730-1-git-send-email-shawnguo@kernel.org>
 <1509073651-23730-2-git-send-email-shawnguo@kernel.org>
 <20171027142606.zilypg7tuxwy3fj2@rob-hp-laptop>
Message-ID: <20171030145150.GB6270@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 09:38:30AM -0500, Rob Herring wrote:
> On Fri, Oct 27, 2017 at 11:07:30AM +0800, Shawn Guo wrote:
> > From: Jianguo Sun <sunjianguo1@huawei.com>
> > 
> > It adds the device tree bindings for PCIE/SATA/USB3 combo PHY found on
> > HiSilicon STB SoCs.
> > 
> > Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../bindings/phy/phy-hi3798cv200-combphy.txt       | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> > new file mode 100644
> > index 000000000000..efb6cd5eae04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
> > @@ -0,0 +1,57 @@
> > +HiSilicon STB PCIE/SATA/USB3 PHY
> 
> Please add a reference to the parent node binding.
> 
> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Just noticed that we do not have a bindings doc for the parent
peripheral controller yet.  I will add a new patch for that in v5.

Shawn
