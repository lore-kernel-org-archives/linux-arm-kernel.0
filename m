From: davem@davemloft.net (David Miller)
Date: Sat, 01 Apr 2017 11:26:03 -0700 (PDT)
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <1491031554-19516-2-git-send-email-dingtianhong@huawei.com>
References: <1491031554-19516-1-git-send-email-dingtianhong@huawei.com>
 <1491031554-19516-2-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170401.112603.1991545644693496714.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Sat, 1 Apr 2017 15:25:51 +0800

> Till now only the Intel ixgbe could support enable
> Relaxed ordering in the drivers for special architecture,
> but the ARCH_WANT_RELAX_ORDER is looks like a general name
> for all arch, so rename to a specific name for intel
> card looks more appropriate.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>

This is not a driver specific facility.

Any driver can test this symbol and act accordingly.

Just because IXGBE is the first and only user, doesn't mean
the facility is driver specific.

Thank you.
