From: amittomer25@gmail.com (Amit Tomer)
Date: Wed, 4 Nov 2015 13:14:29 +0530
Subject: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>
 <5638DE62.6050605@arm.com>
 <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <CABHD4K_BWU7-c1NM0y5ZwFkfpG0+c9_9DpwyNXNcTvavmy8rJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Without #ifdefs if we compile driver for legacy, MSI structures will not be available and we get compile time error.

Sorry for nitpicking but at least can we use elegant version of
#ifdefs .i.e. #if IS_ENABLED() here ?

Thanks,
Amit.
