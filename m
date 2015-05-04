From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 4 May 2015 20:05:57 +0530
Subject: [PATCH v2 2/5] phy: qcom: Add Qualcomm PCIe PHY
In-Reply-To: <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
 <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com>
Message-ID: <554783CD.50708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 04 May 2015 06:12 PM, Stanimir Varbanov wrote:
> Add a PCIe PHY driver used by PCIe host controller driver
> on Qualcomm SoCs like Snapdragon 805.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> ---
>   drivers/phy/Kconfig         |    9 ++
>   drivers/phy/Makefile        |    1 +
>   drivers/phy/phy-qcom-pcie.c |  291 +++++++++++++++++++++++++++++++++++++++++++

Why do you need a new PHY driver for this? Why not use the existing QCOM PHY 
driver. I can see the registers used here in phy-qcom-ufs-qmp-14nm.h?

Thanks
Kishon
