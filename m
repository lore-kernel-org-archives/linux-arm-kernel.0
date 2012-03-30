From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 30 Mar 2012 14:19:33 +0530
Subject: [PATCH] ARM: OMAP2+: Fix omap2+ build error.
In-Reply-To: <1333096516-4252-1-git-send-email-r.sricharan@ti.com>
References: <1333096516-4252-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CAMQu2gyqXsft-DByeGYRt8V-gWB-8B8QJk55WLj5XyO+EMYYKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 2:05 PM, R Sricharan <r.sricharan@ti.com> wrote:
> With CONFIG_OMAP4_ERRATA_I688 enabled, omap2+ build
> was broken as below.
>
> ? ? ? ?arch/arm/kernel/io.c: In function '_memcpy_toio':
> ? ? ? ?arch/arm/kernel/io.c:29: error: implicit declaration of function 'outer_sync'
> ? ? ? ?make[1]: *** [arch/arm/kernel/io.o] Error 1
>
> Fixing this here.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> ?arch/arm/include/asm/barrier.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
Can you please add information about the commit
after this was broken.

Regards
santosh
