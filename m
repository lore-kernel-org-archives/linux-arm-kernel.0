From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 26 Feb 2016 19:06:08 +0100 (CET)
Subject: [RFC v4 07/14] msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <1456508154-2253-8-git-send-email-eric.auger@linaro.org>
References: <1456508154-2253-1-git-send-email-eric.auger@linaro.org>
 <1456508154-2253-8-git-send-email-eric.auger@linaro.org>
Message-ID: <alpine.DEB.2.11.1602261904500.3638@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb 2016, Eric Auger wrote:

> Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
> meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
> Translation Service. On Intel HW this capability is abstracted on IOMMU
> side while on ARM it is abstracted on MSI controller side.
> 
> GICv3 ITS HW is the first HW advertising that feature.

No. We add the flag, epxlain what it does and then in a second step add the
user _after_ all other preliminaries are implemented.
 
Thanks,

	tglx
