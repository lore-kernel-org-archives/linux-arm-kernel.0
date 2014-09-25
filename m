From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 25 Sep 2014 12:39:54 +0200
Subject: [PATCH] [media] exynos4-is: fix some warnings when compiling on
 arm64
In-Reply-To: <416b6af26812eb995333c5bd5a9263775b8c4699.1411607687.git.mchehab@osg.samsung.com>
References: <416b6af26812eb995333c5bd5a9263775b8c4699.1411607687.git.mchehab@osg.samsung.com>
Message-ID: <5423F0FA.7030404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/14 03:24, Mauro Carvalho Chehab wrote:
> Got those warnings when compiling with gcc 4.9.1 for arm64:
> 
> drivers/media/platform/exynos4-is/fimc-isp-video.c: In function ?isp_video_capture_buffer_queue?:
> drivers/media/platform/exynos4-is/fimc-isp-video.c:221:4: warning: format ?%x? expects argument of type ?unsigned int?, but argument 7 has type ?dma_addr_t? [-Wformat=]
>     isp_dbg(2, &video->ve.vdev,
[...]
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Thanks Mauro,

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
