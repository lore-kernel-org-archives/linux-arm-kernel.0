From: joro@8bytes.org (Joerg Roedel)
Date: Sat, 9 Mar 2013 19:02:14 +0100
Subject: [PATCH 8/9] iommu: OMAP: build only on OMAP2+
In-Reply-To: <1362521809-22989-9-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-9-git-send-email-arnd@arndb.de>
Message-ID: <20130309180213.GA4876@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 11:16:48PM +0100, Arnd Bergmann wrote:
> The OMAP IOMMU driver intentionally fails to build on OMAP1
> platforms, so we should not allow enabling it there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu at lists.linux-foundation.org
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Omar Ramirez Luna <omar.luna@linaro.org>

Applied to iommu/fixes, thanks Arnd.
