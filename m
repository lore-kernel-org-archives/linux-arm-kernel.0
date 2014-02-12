From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Wed, 12 Feb 2014 12:07:28 +0800
Subject: [PATCH V6 07/12] phy: st-miphy-40lp: Add SPEAr1310 and
 SPEAr1340 PCIe phy support
In-Reply-To: <52FA122A.1010900@ti.com>
References: <cover.1392109054.git.mohit.kumar@st.com>
 <f84ed875ae7a356a8056f4645a4d1e59c665c972.1392109054.git.mohit.kumar@st.com>
 <52FA122A.1010900@ti.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CACEA@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kishon,

> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: Tuesday, February 11, 2014 5:36 PM
> To: Mohit KUMAR DCG; arnd at arndb.de
> Cc: Pratyush ANAND; Viresh Kumar; spear-devel; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH V6 07/12] phy: st-miphy-40lp: Add SPEAr1310 and
> SPEAr1340 PCIe phy support
> 
> On Tuesday 11 February 2014 03:00 PM, Mohit Kumar wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > SPEAr1310 and SPEAr1340 uses miphy40lp phy for PCIe. This driver adds
> > support for the same.
> 
> What's up with SATA support for SPEAr1310? Do you have plans of adding it
> soon?
> >

- yes we will be doing it after this series is finalized.

[...]
> > +
> > +	regmap_update_bits(priv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
> > +			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
> > +			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);
> > +
> > +	switch (priv->id) {
> 
> 'id' should be made as optional dt property since it's not used for 1340 no?
> 
- ok
Thanks
Mohit
