From: amittomer25@gmail.com (Amit Tomer)
Date: Wed, 25 Nov 2015 14:23:29 +0530
Subject: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <20151125075018.68e97010@arm.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
 <20151124173556.18aff6b5@arm.com>
 <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151125075018.68e97010@arm.com>
Message-ID: <CABHD4K9PH-1tpwmxmPSBK3dW04G3XMfNtPFqtWFb7gnThe=uNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry to intervene but just trying to learn from your comments.

 > You have plenty, and that's the whole of your device space. *All of it*. So
>   just take the base address of your PCIe controller, and be done with
>   it.

but isn't few of PCIe controller's registers itself are mapped
here(base address). So, how can we use this address for MSI?

Or you said from base address of PCIe controller, find an offset that
can be used as MSI address?

Thanks
Amit.
