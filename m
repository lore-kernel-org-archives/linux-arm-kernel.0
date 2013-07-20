From: joro@8bytes.org (Joerg Roedel)
Date: Sat, 20 Jul 2013 09:15:27 +0200
Subject: [PATCH] iommu: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <51E81F23.40807@wwwdotorg.org>
References: <1374013222-4856-1-git-send-email-swarren@wwwdotorg.org>
 <51E81F23.40807@wwwdotorg.org>
Message-ID: <20130720071527.GI28811@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 11:00:19AM -0600, Stephen Warren wrote:
> I'd like to defer actually applying this patch. There is some discussion
> (in the thread for the equivalent ASoC patches) re: the best way to
> handle the ARCH_TEGRA_*_SOC Kconfig options which might affect this
> patch. Any review comment is still appreciated.

Okay, not much to review here. Just let me know if it is still required.


	Joerg
