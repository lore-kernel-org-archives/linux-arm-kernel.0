From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 17 Mar 2014 09:45:51 +0530
Subject: [PATCH] drm/exynos: Fix (more) freeing issues in exynos_drm_drv.c
In-Reply-To: <1395026919-14467-1-git-send-email-djkurtz@chromium.org>
References: <1395026919-14467-1-git-send-email-djkurtz@chromium.org>
Message-ID: <CAK9yfHx5XFA1GyoHsRMgh2FpQ-4+pe=5302ZBJYUK6hLwdVLSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for the patch.

On 17 March 2014 08:58, Daniel Kurtz <djkurtz@chromium.org> wrote:
> The following commit [0] fixed a use-after-free, but left the subdrv open
> in the error path.
>
> [0] commit 6ca605f7c70895a35737435f17ae9cc5e36f1466
> drm/exynos: Fix freeing issues in exynos_drm_drv.c
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Sachin Kamat <sachin.kamat@linaro.org>

-- 
With warm regards,
Sachin
