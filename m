From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Feb 2012 11:55:15 +0530
Subject: [PATCH 4/5] ARM: OMAP2+: gpmc: Use irq_alloc_descs instead of
 static IRQ range
In-Reply-To: <1330035801-14937-5-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
 <1330035801-14937-5-git-send-email-b-cousson@ti.com>
Message-ID: <CAMQu2gwO=Kv5aPfrXuVOVMDA2P=S0SfR2ekMPT6o4MBTRsXHMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> The gpmc code is still not a proper driver and is still using the bad old
> static way of declaring its IRQ range for the various CS it can handle (8).
>
> Use irq_alloc_descs to get dynamically a set of IRQ descriptors.
> Clean some bad line wrapping here and there.
>
> Please note that this code is still not a real driver after this fix, and
> will require a massive cleanup...
>
Agree.

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> ?arch/arm/mach-omap2/gpmc.c | ? 22 +++++++++++++++-------
> ?1 files changed, 15 insertions(+), 7 deletions(-)
>
For the patch,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
