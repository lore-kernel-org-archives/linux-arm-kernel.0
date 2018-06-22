From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 22 Jun 2018 16:39:35 +0800
Subject: Supporting more IRQs than NR_IRQS + 8196 on ARM64 server
Message-ID: <5B2CB5C7.1020801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marc
     Current system only supports (NR_IRQS + 8196) interrupts.  It's not 
enough on ARM64
server, on D06 we have several pcie devices and each device supports 256 
VMs and each
VM uses 64 interrupts. Can we set NR_IRQS to a bigger value to support 
more interrupts ?

Thanks,
Yang
