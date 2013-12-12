From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 12 Dec 2013 19:47:02 +0900
Subject: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada,
 R-Car PCI host maintainers
In-Reply-To: <20131212070045.GO18380@S2101-09.ap.freescale.net>
References: <20131211183237.GI4699@google.com>
 <20131212070045.GO18380@S2101-09.ap.freescale.net>
Message-ID: <000001cef727$7da93730$78fba590$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 12, 2013 4:01 PM, Shawn Guo wrote:
> On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> > +PCI DRIVER FOR IMX6
> > +M:	Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks for the nomination.  But I think a better person for this
> position would be Richard Zhu <r65037@freescale.com> (copied).  He knows
> the driver and controller much better than myself, and most importantly
> he is the driver owner for Freescale kernel and he has the contact to
> Freescale PCIe hardware people.

I agree with Shawn Guo's opinion. :-)

Richard Zhu has been maintaining i.MX6 PCIe driver. Also he can contact
Freescale PCIe hardware engineers. Thus, he is the appropriate person
for the Maintainer of i.MX PCIe.

Best regards,
Jingoo Han

> 
> Shawn
> 
> > +L:	linux-pci at vger.kernel.org
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/pci/host/*imx6*
