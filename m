From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 12 Jan 2015 11:20:29 -0700
Subject: [PATCH 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
 <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
Message-ID: <20150112182029.GA2776@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 07:14:00PM +0200, Stanimir Varbanov wrote:
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>  drivers/pci/host/Kconfig     |    9 +
>  drivers/pci/host/Makefile    |    1 +
>  drivers/pci/host/pcie-qcom.c |  415 ++++++++++++++++++++++++++++++++++++++++++

Hi Stanimir,

Can you also add a MAINTAINERS update so I'll know who should ack changes
to this driver?

Bjorn
