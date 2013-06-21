From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 21 Jun 2013 13:38:29 +0900
Subject: [PATCH V9 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <51C3D517.1080301@st.com>
References: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
 <51C3D517.1080301@st.com>
Message-ID: <003601ce6e39$2dd30b40$897921c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 21, 2013 1:23 PM, Pratyush Anand wrote:
> On 6/21/2013 8:51 AM, Jingoo Han wrote:
> > diff --git a/drivers/pci/host/pci-designware.c b/drivers/pci/host/pci-designware.c
> > new file mode 100644
> > index 0000000..f8558ff
> > --- /dev/null
> > +++ b/drivers/pci/host/pci-designware.c
> 
> If you plan to send next version, then I would suggest to rename it as
> pcie-designware.c, because synopsis pcie and pci controllers are different.

OK, I see.
I rename it as 'pcie-designware.c'.
Thank you for your suggestion. :)

Best regards,
Jingoo Han

> 
> Regards
> Pratyush
> 
> 
