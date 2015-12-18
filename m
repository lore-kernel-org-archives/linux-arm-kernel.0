From: lkp@intel.com (kbuild test robot)
Date: Fri, 18 Dec 2015 21:44:15 +0800
Subject: [PATCH v5 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <1450442339-18765-4-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <201512182111.1GLn2hxy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stanimir,

[auto build test WARNING on next-20151218]
[also build test WARNING on v4.4-rc5]
[cannot apply to pci/next robh/for-next v4.4-rc5 v4.4-rc4 v4.4-rc3]

url:    https://github.com/0day-ci/linux/commits/Stanimir-Varbanov/Qualcomm-PCIe-driver-and-designware-fixes/20151218-205427


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/host/pcie-qcom.c:188:1-3: WARNING: PTR_ERR_OR_ZERO can be used
   drivers/pci/host/pcie-qcom.c:220:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
