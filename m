From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 20 Oct 2015 20:14:46 +0900
Subject: [PATCH v5 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1445332540-12814-7-git-send-email-pankaj.dubey@samsung.com>
References: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
 <1445332540-12814-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20151020111446.GB923@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 02:45:37PM +0530, Pankaj Dubey wrote:
> This patch adds Exynos SROM controller driver which will handle
> save restore of SROM registers during S2R.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

...

> +config EXYNOS_SROM
> +	bool
> +	depends on ARM && ARCH_EXYNOS && PM

Cool, thanks! If you want you can add my review.

Andi
