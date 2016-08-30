From: jingoohan1@gmail.com (Jingoo Han)
Date: Tue, 30 Aug 2016 11:46:13 -0400
Subject: [PATCH 0/3] pcie-designware: support for external MSI controller
In-Reply-To: <20160830172447.65d10772@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160830172447.65d10772@free-electrons.com>
Message-ID: <000c01d202d5$a3809bd0$ea81d370$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 30, 2016 11:25 AM, Thomas Petazzoni wrote:
> 
> Hello,
> 
> On Tue, 30 Aug 2016 14:57:07 +0200, Thomas Petazzoni wrote:
> 
> > Thomas Petazzoni (3):
> >   dt-bindings: designware-pcie: document optional msi-parent property
> >   pci: pcie-designware: add support for external MSI controller
> >   arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K
> 
> Please discard this patch series, it's just pure crap. No changes at all
> are needed on the pcie-designware driver, using the msi-parent property
> already works, and my new code does nothing good.
> 
> The of_pci_find_msi_chip_by_node() API is on its way to being removed, and
> it doesn't return anything useful.
> 
> Only PATCH 3/3 is needed, which I'll resubmit separately.
> 
> Sorry for the noise.

Oh, good.
The support for External MSI controller is really necessary.
Thank you for your patch!

Best regards,
Jingoo Han

> 
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
