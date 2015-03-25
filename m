From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 25 Mar 2015 17:43:21 +0100
Subject: [PATCH v8 23/30] PCI/mvebu: Use pci_common_init_dev() to
 simplify code
In-Reply-To: <551277E6.1010307@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
 <1427168064-8657-24-git-send-email-wangyijing@huawei.com>
 <551277E6.1010307@huawei.com>
Message-ID: <20150325174321.4a5bc25d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Yijing Wang,

On Wed, 25 Mar 2015 16:55:02 +0800, Yijing Wang wrote:

>    Do you have any comment for this patch ? In this series, pci_bus_add_devices()
> has been ripped out from pci_scan_root_bus(), so I think the pci_scan_root_bus() is
> almost the same as pci_create_root_bus + pci_scan_child_bus(). And in this series,
> we try to unexport pci_create_root_bus(). It's even better if you could help test this changes.

I'm away this week for ELC, but I promise to test you patch series on
mvebu hardware next week.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
