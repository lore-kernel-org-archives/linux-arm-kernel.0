From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Aug 2012 15:33:42 +0100
Subject: [PATCH V4 0/2] arm: samsung: Move FIMD headers to include/video/
In-Reply-To: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
Message-ID: <20120807143342.GD18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 06:04:30PM +0530, Leela Krishna Amudala wrote:
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159 --------------------
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
>  drivers/video/s3c-fb.c                             |    2 +-
>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  152 +++++++++++++++++--

Isn't include/video for framebuffer drivers?  Isn't this more a DRM thing?
Wouldn't include/drm therefore be more appropriate?
