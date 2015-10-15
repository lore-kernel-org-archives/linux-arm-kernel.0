From: gustavo@padovan.org (Gustavo Padovan)
Date: Fri, 16 Oct 2015 01:17:20 +0900
Subject: [PATCH v4 05/79] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <1444888618-4506-6-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
 <1444888618-4506-6-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <20151015161720.GD8564@joana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-15 Mikko Rapeli <mikko.rapeli@iki.fi>:

> Fixes userspace compilation error:
> 
> drm/exynos_drm.h:30:2: error: unknown type name ?uint64_t?
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> ---
>  include/uapi/drm/exynos_drm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

	Gustavo
