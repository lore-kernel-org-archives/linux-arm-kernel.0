From: davem@davemloft.net (David Miller)
Date: Sun, 06 Aug 2017 20:47:44 -0700 (PDT)
Subject: [PATCH v9 0/4] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170806.204744.1934067595236180060.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Sat, 5 Aug 2017 15:15:09 +0800

> Some devices have problems with Transaction Layer Packets with the Relaxed
> Ordering Attribute set.  This patch set adds a new PCIe Device Flag,
> PCI_DEV_FLAGS_NO_RELAXED_ORDERING, a set of PCI Quirks to catch some known
> devices with Relaxed Ordering issues, and a use of this new flag by the
> cxgb4 driver to avoid using Relaxed Ordering with problematic Root Complex
> Ports.
> 
> It's been years since I've submitted kernel.org patches, I appolgise for the
> almost certain submission errors.

Which tree should merge this?  The PCI tree or my networking tree?
