From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 28 Aug 2015 10:51:42 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable big.LITTLE CPUidle support
In-Reply-To: <1440749769-10135-1-git-send-email-javier@osg.samsung.com>
References: <1440749769-10135-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1440751902.13118.6.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-28 at 10:16 +0200, Javier Martinez Canillas wrote:
> Some Exynos big.LITTLE boards (i.e: Exynos5420 and Exynos5800 based
> Chromebooks) have proper firmware that allow the big.LITTLE CPUidle
> driver to work correctly, so enable support for this.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Kukjin and Krzysztof,
> 
> As you know there are other boards like the Exynos5422 based Odroid 
> XU{3,4}
> whose firmware is broken due leaving CCI in secure mode which means 
> that the
> kernel MCPM support can't properly manage CCI.
> 
> So if you pick this patch, it should be tested in kernelci before 
> appearing
> in linux-next to prevent any boot issues.

I've pushed this patch into Collabora's for-next branch, which should
get picked up by kernelci soonish.

-- 
Sjoerd Simons
Collabora Ltd.
