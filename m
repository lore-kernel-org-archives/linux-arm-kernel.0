From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 2 Jul 2014 13:02:38 +0100
Subject: [PATCH 2/5] phy: miphy365x: Add MiPHY365x header file for DT x
 Driver defines
In-Reply-To: <53B3D0BE.9090708@ti.com>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
 <1404133317-25953-3-git-send-email-lee.jones@linaro.org>
 <53B3D0BE.9090708@ti.com>
Message-ID: <20140702120238.GC16724@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jul 2014, Kishon Vijay Abraham I wrote:
> On Monday 30 June 2014 06:31 PM, Lee Jones wrote:
> > This provides the shared header file which will be reference from both
> > the MiPHY365x driver and its associated Device Tree node(s).
> > 
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/dt-bindings/phy/phy-miphy365x.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 include/dt-bindings/phy/phy-miphy365x.h

[...]

> > +#define MIPHY_SATA_PORT0		(MIPHY_TYPE_SATA) | (MIPHY_PORT_0)
> > +#define MIPHY_SATA_PORT1		(MIPHY_TYPE_SATA) | (MIPHY_PORT_1)
> > +#define MIPHY_PCIE_PORT0		(MIPHY_TYPE_PCIE) | (MIPHY_PORT_0)
> > +#define MIPHY_PCIE_PORT1		(MIPHY_TYPE_PCIE) | (MIPHY_PORT_1)
> 
> As Sergei pointed in your previous version it should be (X | Y).

Hmm, yes.  I even have his email marked as 'important' and to fix that
up.  Sorry about that, will fix.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
