From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 30 Jan 2012 11:34:21 -0600
Subject: [PATCH] tidspbridge: Rename module from bridgedriver to
 tidspbridge
In-Reply-To: <1327440305.1798.28.camel@joe2Laptop>
References: <1327440305.1798.28.camel@joe2Laptop>
Message-ID: <CAB-zwWjWkxpmT2dXDV++okCKZaebVz4O8-L4OgabMEzdEu4eGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 3:25 PM, Joe Perches <joe@perches.com> wrote:
> tidspbridge when built as a module is named bridgedriver.
>
> bridgedriver is not a particularly good module name.
>
> tidspbridge is what the source is named. ?That seems
> a more appropriate module name too as it describes
> the hardware function better.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> ?drivers/staging/tidspbridge/Makefile | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/Makefile b/drivers/staging/tidspbridge/Makefile
> index fd6a276..8c8c92a 100644
> --- a/drivers/staging/tidspbridge/Makefile
> +++ b/drivers/staging/tidspbridge/Makefile
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_TIDSPBRIDGE) ? ? ?+= bridgedriver.o
> +obj-$(CONFIG_TIDSPBRIDGE) ? ? ?+= tidspbridge.o
>
> ?libgen = gen/gh.o gen/uuidutil.o
> ?libcore = core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3430.o \
> @@ -13,7 +13,7 @@ libdload = dynload/cload.o dynload/getsection.o dynload/reloc.o \
> ? ? ? ? ? ? ? ? dynload/tramp.o
> ?libhw = hw/hw_mmu.o
>
> -bridgedriver-y := $(libgen) $(libservices) $(libcore) $(libpmgr) $(librmgr) \
> +tidspbridge-y := $(libgen) $(libservices) $(libcore) $(libpmgr) $(librmgr) \
> ? ? ? ? ? ? ? ? ? ? ? ?$(libdload) $(libhw)
>
> ?#Machine dependent
>
>

Sound good to me, and unless there is an objection, it also gives
plenty of time for the change to be noticed.

Regards,

Omar
