From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 12 Sep 2012 11:28:22 +0530
Subject: [PATCH] ARM: OMAP2+: TEMP: Round of the carve out memory
 requested to section_size
In-Reply-To: <1347429117-10919-1-git-send-email-r.sricharan@ti.com>
References: <1347429117-10919-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CAMQu2gxaamzm8i=ZcCU+99NnA6dDgi6H0GJwVtSmYWjPcyk5WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:21 AM, R Sricharan <r.sricharan@ti.com> wrote:
> memblock_steal tries to reserve physical memory during boot.
> When the requested size is not aligned on the section size
> then, the remaining memory available for lowmem becomes
> unaligned on the section boundary. There is a issue with this,
> which is discussed in the thread below.
>
> https://lkml.org/lkml/2012/6/28/112
>
> The final conclusion from the thread seems to
> be align the memblock_steal calls on the SECTION boundary.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
Why is the TEMP in the subject line. From patch it doesn't be
temporary version. Can you please clarify that ?

Regards
Santosh
