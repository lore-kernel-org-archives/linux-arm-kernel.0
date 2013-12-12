From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Thu, 12 Dec 2013 13:06:16 +0800
Subject: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI
 host maintainers
In-Reply-To: <000f01cef6bf$cd0fe340$672fa9c0$%han@samsung.com>
References: <20131211183237.GI4699@google.com>
 <20131211184321.GJ4699@google.com>
 <000f01cef6bf$cd0fe340$672fa9c0$%han@samsung.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F642F@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han at samsung.com]
> Sent: Thursday, December 12, 2013 3:55 AM
> To: 'Bjorn Helgaas'; linux-pci at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-tegra at vger.kernel.org; linux-sh at vger.kernel.org; linux-samsung-
> soc at vger.kernel.org; 'Shawn Guo'; 'Jason Cooper'; 'Thierry Reding'; 'Simon
> Horman'; 'Magnus Damm'; 'Valentine Barshak'; 'Wei Yongjun'; 'Wei Yongjun';
> 'Kuninori Morimoto'; Mohit KUMAR DCG; Pratyush ANAND; 'Jingoo Han'
> Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car
> PCI host maintainers
> 
> On Thursday, December 12, 2013 3:43 AM, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> > > If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> >
> > And I see Mohit's patch [1] to update the DesignWare entry:
> >
> > +PCIE DRIVER FOR SYNOPSIS DESIGNWARE CONTROLLER
> > +M:	Mohit Kumar <mohit.kumar@st.com>
> > +M:	Jingoo Han <jg1.han@samsung.com>
> > +L:	linux-pci at vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/pci/host/pcie-designware.c
> >
> > I can fold in that update too if Jingoo acks it.
> >
> > [1] http://patchwork.ozlabs.org/patch/299905/
> 
> Hi Bjorn,
> 
> I agree with this. :-)
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
- Thanks Bjorn and Jingoo. I will remove this patch from my v2 patches.

Regards
Mohit
