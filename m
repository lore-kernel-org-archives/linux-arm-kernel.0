From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue, 15 Dec 2015 10:24:07 +0200
Subject: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <566FCE27.2050705@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 03:35 PM, Stanimir Varbanov wrote:
> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  MAINTAINERS                  |    7 +
>  drivers/pci/host/Kconfig     |   10 +
>  drivers/pci/host/Makefile    |    1 +
>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 642 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-qcom.c

Hi Bjorn, any chance to get this merged in 4.5 ?


-- 
regards,
Stan
