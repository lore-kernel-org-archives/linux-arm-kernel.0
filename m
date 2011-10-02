From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 20:01:30 +0200
Subject: [PATCH 10/30] ARM: omap/iommu: always provide iommu debug code
In-Reply-To: <CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-11-git-send-email-arnd@arndb.de>
	<CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
Message-ID: <1377050.B9gMvYWCVB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 18:34:52 Ohad Ben-Cohen wrote:
> 
> The driver has moved to drivers/iommu/ and changed a bit, but this
> patch is still relevant.
> 
> The merge conflict will be trivial to resolve, but if you prefer, we
> can prevent it by taking this patch via the iommu tree.

Yes, please take it into the iommu tree, so I don't have to track
the conflict.

Thanks,

	Arnd
