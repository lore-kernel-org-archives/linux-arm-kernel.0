From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 16 Dec 2015 15:17:25 -0600
Subject: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <566FCE27.2050705@mm-sol.com>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
 <566FCE27.2050705@mm-sol.com>
Message-ID: <20151216211725.GA27791@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stan,

On Tue, Dec 15, 2015 at 10:24:07AM +0200, Stanimir Varbanov wrote:
> On 12/03/2015 03:35 PM, Stanimir Varbanov wrote:
> > From: Stanimir Varbanov <svarbanov@mm-sol.com>
> > 
> > The PCIe driver reuse the Designware common code for host
> > and MSI initialization, and also program the Qualcomm
> > application specific registers.
> > 
> > Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > ---
> >  MAINTAINERS                  |    7 +
> >  drivers/pci/host/Kconfig     |   10 +
> >  drivers/pci/host/Makefile    |    1 +
> >  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 642 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-qcom.c
> 
> Hi Bjorn, any chance to get this merged in 4.5 ?

The driver looks good overall, so I think 4.5 is very possible.  It
doesn't look like there's really a consensus on the memory barrier
thing yet, and I assume the testing reports include that first patch,
so it'd be good to get that resolved first.

Bjorn
