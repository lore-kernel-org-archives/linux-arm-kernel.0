From: davem@davemloft.net (David Miller)
Date: Mon, 14 Aug 2017 22:15:12 -0700 (PDT)
Subject: [PATCH v11 0/5] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <1502767407-6812-1-git-send-email-dingtianhong@huawei.com>
References: <1502767407-6812-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170814.221512.1430356980828045690.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Tue, 15 Aug 2017 11:23:22 +0800

> Some devices have problems with Transaction Layer Packets with the Relaxed
> Ordering Attribute set.  This patch set adds a new PCIe Device Flag,
> PCI_DEV_FLAGS_NO_RELAXED_ORDERING, a set of PCI Quirks to catch some known
> devices with Relaxed Ordering issues, and a use of this new flag by the
> cxgb4 driver to avoid using Relaxed Ordering with problematic Root Complex
> Ports.
 ...

Series applied, thanks.
