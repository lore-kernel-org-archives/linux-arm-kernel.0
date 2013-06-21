From: pratyush.anand@st.com (Pratyush Anand)
Date: Fri, 21 Jun 2013 09:52:47 +0530
Subject: [PATCH V9 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
References: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
Message-ID: <51C3D517.1080301@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2013 8:51 AM, Jingoo Han wrote:
> diff --git a/drivers/pci/host/pci-designware.c b/drivers/pci/host/pci-designware.c
> new file mode 100644
> index 0000000..f8558ff
> --- /dev/null
> +++ b/drivers/pci/host/pci-designware.c

If you plan to send next version, then I would suggest to rename it as 
pcie-designware.c, because synopsis pcie and pci controllers are different.

Regards
Pratyush
