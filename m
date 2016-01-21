From: davem@davemloft.net (David Miller)
Date: Thu, 21 Jan 2016 12:02:22 -0800 (PST)
Subject: [patch v3 net-next] net: hns: enet specifies a reference to dsaf
In-Reply-To: <1453276819-22062-1-git-send-email-yankejian@huawei.com>
References: <1453276819-22062-1-git-send-email-yankejian@huawei.com>
Message-ID: <20160121.120222.814054146075427022.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kejian Yan <yankejian@huawei.com>
Date: Wed, 20 Jan 2016 16:00:19 +0800

> This patch replace the assoication between dsaf and enet from string
> matching to object reference. It requires the DTS to be updated within
> BIOS. Thanks god it can be done for all released boards.
> 
> Signed-off-by: Kejian Yan <yankejian@huawei.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Yisen Zhuang <yisen.zhuang@huawei.com>

Applied, thanks.
