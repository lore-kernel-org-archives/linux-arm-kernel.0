From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 20 Dec 2012 15:05:04 +0200
Subject: [PATCH] hwspinlock/core: Kernel panic when enable
 DEBUG_SPINLOCK_SLEEP config.
In-Reply-To: <CAKvkGKcLU4ehteAqozw6+dCodSoQvJRSkpnu85um0C62c7RzSg@mail.gmail.com>
References: <CAKvkGKcLU4ehteAqozw6+dCodSoQvJRSkpnu85um0C62c7RzSg@mail.gmail.com>
Message-ID: <CAK=WgbbWNEJB79iPURdYM52HtoyvsFeoEUvfodwWg5qvtMhQyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

On Thu, Dec 20, 2012 at 2:44 PM, steve.zhan <zhanzhenbo@gmail.com> wrote:
>                 When enable this config to check kernel, kernel will
> complain panic at slab.c(kmem_cache_alloc function): "BUG: sleeping function
> called from invalid context".

Which kernel version are you using ?

Specifically, do you have commit
93b465c2e186d96fb90012ba0f9372eb9952e732 "hwspinlock/core: use a mutex
to protect the radix tree" ?

Thanks,
Ohad.
