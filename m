From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Thu, 12 Dec 2013 13:00:30 +0800
Subject: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
In-Reply-To: <201312112342.43840.arnd@arndb.de>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
 <201312112342.43840.arnd@arndb.de>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, December 12, 2013 4:13 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Mohit KUMAR DCG; linux-pci at vger.kernel.org; Pratyush ANAND; spear-
> devel; Viresh Kumar
> Subject: Re: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
> 
> On Wednesday 11 December 2013, Mohit Kumar wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > Follow dt clock naming convention for PCIe clocks.
> >
> 
> I think in the future, the spear clocks really need to get moved into DT
> representations, as we do for other platforms, which will get rid of a lot of
> code in drivers/clk, including all the clkdev registration.
-  Let it be this way for now. May be we will improve it in next cycle.

Thanks
Mohit	
