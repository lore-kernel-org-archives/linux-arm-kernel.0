From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 20 Sep 2016 10:28:20 +0200
Subject: [PATCH] drm/exynos: mark exynos_dp_crtc_clock_enable() static
In-Reply-To: <1474207110-16111-1-git-send-email-baoyou.xie@linaro.org>
References: <CGME20160920024446eucas1p18933d6821f5194e56b208095959ac39c@eucas1p1.samsung.com>
 <1474207110-16111-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <d9014b26-39fb-ee90-fbdd-dbb0a25350e2@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.2016 15:58, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/gpu/drm/exynos/exynos_dp.c:46:5: warning: no previous prototype for 'exynos_dp_crtc_clock_enable' [-Wmissing-prototypes]
>
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
