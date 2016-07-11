From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 11 Jul 2016 12:49:30 +0200
Subject: [PATCH v2 1/7] bindings: spi-samsung: add exynos5433 spi
 compatible
In-Reply-To: <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <578379BA.3090501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 04:46 PM, Andi Shyti wrote:
> The samsung,exynos5433-spi has some peculiarities that bring the
> need of creating a new compatible in the binding.
> 
> One of those is the 3-clocks controller management where the spi
> is fed with three clocks: "spi", "busclkN" and "ioclk".
> 
> By adding the exynos5433-spi, we deprecate the exynos7 compatible
> and discourage its use.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
