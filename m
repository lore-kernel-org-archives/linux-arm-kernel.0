From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 18 Sep 2015 16:29:34 +0200
Subject: [PATCH 1/4] s5p-jpeg: generalize clocks handling
In-Reply-To: <1442586060-23657-2-git-send-email-andrzej.p@samsung.com>
References: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
 <1442586060-23657-2-git-send-email-andrzej.p@samsung.com>
Message-ID: <55FC1FCE.1010208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej, Marek,

On 09/18/2015 04:20 PM, Andrzej Pietrasiewicz wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Allow jpeg codec variants declare clocks they need.
> Before this patch is applied jpeg-core gets jpeg->sclk
> "speculatively": if it is not there, we assume no problem.
>
> This patch eliminates this by explicitly declaring
> what clocks are needed for each variant.
>
> This is a preparation for adding Exynos 5433 variant support, which
> needs 4 clocks of names not compatible with any previous version of
> jpeg hw module.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> [Rebase and commit message]
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> ---
>   drivers/media/platform/s5p-jpeg/jpeg-core.c | 66 ++++++++++++++---------------
>   drivers/media/platform/s5p-jpeg/jpeg-core.h | 10 +++--
>   2 files changed, 37 insertions(+), 39 deletions(-)

Reviewed-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
