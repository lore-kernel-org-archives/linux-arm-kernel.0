From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 2 Oct 2011 18:34:52 +0200
Subject: [PATCH 10/30] ARM: omap/iommu: always provide iommu debug code
In-Reply-To: <1317566760-25681-11-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-11-git-send-email-arnd@arndb.de>
Message-ID: <CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The iommu module on omap contains a few functions that are
> only used by the debug module. These are however only there
> when the debug code is built as a module. Since it is possible
> to build the debug code into the kernel, the functions should
> also be provided for the built-in case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?arch/arm/plat-omap/iommu.c | ? ?2 +-

Thanks, Arnd.

The driver has moved to drivers/iommu/ and changed a bit, but this
patch is still relevant.

The merge conflict will be trivial to resolve, but if you prefer, we
can prevent it by taking this patch via the iommu tree.

Thanks,
Ohad.
