From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Dec 2013 15:00:47 +0800
Subject: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI
 host maintainers
In-Reply-To: <20131211183237.GI4699@google.com>
References: <20131211183237.GI4699@google.com>
Message-ID: <20131212070045.GO18380@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> +PCI DRIVER FOR IMX6
> +M:	Shawn Guo <shawn.guo@linaro.org>

Thanks for the nomination.  But I think a better person for this
position would be Richard Zhu <r65037@freescale.com> (copied).  He knows
the driver and controller much better than myself, and most importantly
he is the driver owner for Freescale kernel and he has the contact to
Freescale PCIe hardware people.

Shawn

> +L:	linux-pci at vger.kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*imx6*
