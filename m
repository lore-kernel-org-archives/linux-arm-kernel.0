From: cl@linux.com (Christoph Lameter)
Date: Fri, 5 Oct 2012 16:46:20 +0000
Subject: [PATCH 06/16] mm/slob: use min_t() to compare ARCH_SLAB_MINALIGN
In-Reply-To: <1349448930-23976-7-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-7-git-send-email-arnd@arndb.de>
Message-ID: <0000013a31d206df-8822ffd8-055d-4e9b-9b81-a8ec130ccc9d-000000@email.amazonses.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Oct 2012, Arnd Bergmann wrote:

> Without this patch, building ARM collie_defconfig results in:
>
> mm/slob.c: In function '__kmalloc_node':
> mm/slob.c:431:152: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> mm/slob.c: In function 'kfree':
> mm/slob.c:484:153: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> mm/slob.c: In function 'ksize':
> mm/slob.c:503:153: warning: comparison of distinct pointer types lacks a cast [enabled by default]

Acked-by: Christoph Lameter <cl@linux.com>
