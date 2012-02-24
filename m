From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Feb 2012 11:53:49 +0530
Subject: [PATCH 2/5] ARM: OMAP: irqs: Delete irqs-44xx.h file
In-Reply-To: <1330035801-14937-3-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
 <1330035801-14937-3-git-send-email-b-cousson@ti.com>
Message-ID: <CAMQu2gxhEuw_9Mr4_9LVwrOyaOE1oj6fc_pUG-RJ5KHcr1-c1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> Since all IRQs should be retrieved using hwmod for the moment
> and then device tree in the future, there is no need to keep
> a file defining all the IRQ numbers.
>
> Delete the file and copy the 4 entries that are still used
> directly by the board / driver until the code is properly cleaned.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> ?arch/arm/plat-omap/include/plat/irqs-44xx.h | ?144 ---------------------------
> ?arch/arm/plat-omap/include/plat/irqs.h ? ? ?| ? 15 +++-
> ?2 files changed, 12 insertions(+), 147 deletions(-)
> ?delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h
>
Nice. -144 :)
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
