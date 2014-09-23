From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 23 Sep 2014 15:09:36 -0600
Subject: [PATCH v1 00/21] Use MSI chip to configure MSI/MSI-X in all
 platforms
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20140923210936.GC27117@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 06:09:45PM +0800, Yijing Wang wrote:
> This series is based Bjorn's pci-next branch + Alexander Gordeev's two patches
> "Remove arch_msi_check_device()" link: https://lkml.org/lkml/2014/7/12/41
> 
> Currently, there are a lot of weak arch functions in MSI code.
> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
> This series use MSI chip framework to refactor MSI code across all platforms
> to eliminate weak arch functions. It has been tested fine in x86(with or without
> irq remap).

I see you plan some updates, so I'll look for a v2 posting after v3.17 releases.
It will be great to get rid of some of those weak functions!

Bjorn
