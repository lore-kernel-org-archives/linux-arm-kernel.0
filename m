From: davem@davemloft.net (David Miller)
Date: Thu, 13 Apr 2017 10:53:58 -0400 (EDT)
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
References: <20170401.112603.1991545644693496714.davem@davemloft.net>
 <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
Message-ID: <20170413.105358.633309964366964915.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Date: Thu, 13 Apr 2017 09:10:32 +0000

> Wouldn't it be more correct to have this as a driver specific symbol
> now and move it to a generic one later once we have other drivers
> requiring it?

No, it would not.
