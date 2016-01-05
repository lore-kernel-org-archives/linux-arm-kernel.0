From: richard@nod.at (Richard Weinberger)
Date: Wed, 6 Jan 2016 00:12:42 +0100
Subject: [PATCH v2 12/32] x86/um: reuse asm-generic/barrier.h
In-Reply-To: <1451572003-2440-13-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-13-git-send-email-mst@redhat.com>
Message-ID: <568C4DEA.5070601@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.12.2015 um 20:07 schrieb Michael S. Tsirkin:
> On x86/um CONFIG_SMP is never defined.  As a result, several macros
> match the asm-generic variant exactly. Drop the local definitions and
> pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
