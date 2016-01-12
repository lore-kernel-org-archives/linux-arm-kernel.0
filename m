From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Jan 2016 15:11:14 +0100 (CET)
Subject: [PATCH v3 27/41] x86: define __smp_xxx
In-Reply-To: <1452426622-4471-28-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-28-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.11.1601121511030.3575@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Jan 2016, Michael S. Tsirkin wrote:

> This defines __smp_xxx barriers for x86,
> for use by virtualization.
> 
> smp_xxx barriers are removed as they are
> defined correctly by asm-generic/barriers.h
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
