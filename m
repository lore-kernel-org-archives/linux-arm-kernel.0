From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 14:26:26 +0100
Subject: [GIT PULL 1/2] Samsung fixes for v3.18
In-Reply-To: <546F3CDA.6000908@kernel.org>
References: <546F3CDA.6000908@kernel.org>
Message-ID: <201411271426.26665.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014, Kukjin Kim wrote:
> The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:
> 
>   Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-fixes-v3.18
> 
> for you to fetch changes up to 0526f276f94758245ac5886604fe8c805c1b6d2c:
> 
>   ARM: dts: Explicitly set dr_mode on exynos5250-snow (2014-11-19
> 16:52:15 +0900)
> 
> ----------------------------------------------------------------
> Samsung fixes for v3.18
> 
> - explicitly set dr_mode on exynos5250-snow
>   this is required when kernel is built with USB gadget support.
> 

Pulled into fixes, thanks!

The patch looks like it should be backported to stable kernels
but doesn't have the cc header, are you going to send it to
stable at vger.kernel.org once it hits mainline?

	Arnd
