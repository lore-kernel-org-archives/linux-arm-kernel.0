From: davem@davemloft.net (David Miller)
Date: Thu, 31 Dec 2015 14:44:03 -0500 (EST)
Subject: [PATCH v2 24/32] sparc: define __smp_xxx
In-Reply-To: <1451572003-2440-25-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-25-git-send-email-mst@redhat.com>
Message-ID: <20151231.144403.84288151398339321.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:08:53 +0200

> This defines __smp_xxx barriers for sparc,
> for use by virtualization.
> 
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
