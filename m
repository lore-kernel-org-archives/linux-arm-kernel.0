From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 8 Nov 2018 09:35:54 +0530
Subject: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
In-Reply-To: <1541643072.23791.3.camel@mtksdaap41>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
 <1541643072.23791.3.camel@mtksdaap41>
Message-ID: <20181108040551.GB3046@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 10:11:12AM +0800, Yingjoe Chen wrote:
> On Wed, 2018-11-07 at 23:18 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
> >  include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 +++++++++++++++++
> >  2 files changed, 1451 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> >  create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> > new file mode 100644
> > index 000000000000..bd83401e6179
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> 
> Sorry if this is discussed.
> 
> What's the difference between this and
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt?
> Should this be added to pinctrl-mt65xx.txt?
>

Currently there are 3 different pinctrl core's available for MediaTek
SoCs:

1. Legacy core - pinctrl-mtk-common.c
2. Moore core - pinctrl-moore.c pinctrl-mtk-common-v2.c
3. Paris core - pinctrl-paris.c pinctrl-mtk-common-v2.c

AFAIU pinctrl-mt65xx binding documents the SoC's based on MediaTek's legacy
pinctrl-mtk-common.c core. Whereas MT6797 is based on the MediaTek's Paris
core. There isn't any binding doc available for the Paris core SoC's yet.
That's why I have created a new bindings doc and expecting the remaining SoC's
of Paris family to be included in new pinctrl-mt6797.txt.

Hope this makes clear!

Thanks,
Mani

> Joe.C
> 
> 
