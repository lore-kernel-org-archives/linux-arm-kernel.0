From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Jan 2016 15:10:49 +0100 (CET)
Subject: [PATCH v3 13/41] x86: reuse asm-generic/barrier.h
In-Reply-To: <1452426622-4471-14-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-14-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.11.1601121510380.3575@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Jan 2016, Michael S. Tsirkin wrote:

> As on most architectures, on x86 read_barrier_depends and
> smp_read_barrier_depends are empty.  Drop the local definitions and pull
> the generic ones from asm-generic/barrier.h instead: they are identical.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
