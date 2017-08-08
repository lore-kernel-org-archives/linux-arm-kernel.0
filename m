From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 8 Aug 2017 11:29:13 +0200
Subject: [PATCH] MAINTAINERS: Update Cavium ThunderX2 entry
In-Reply-To: <1502154424-3429-1-git-send-email-jnair@caviumnetworks.com>
References: <1502154424-3429-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170808092913.GE17961@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.17 01:07:04, Jayachandran C wrote:
> Add Robert Richter as the primary maintainer for this platform.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44cb004..f2d8963 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3155,6 +3155,7 @@ S:	Supported
>  F:	drivers/crypto/cavium/cpt/
>  
>  CAVIUM THUNDERX2 ARM64 SOC
> +M:	Robert Richter <rric@kernel.org>

I better want to use my Cavium's email address here, see patch below.

Thanks,

-Robert

>  M:	Jayachandran C <jnair@caviumnetworks.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.7.4
> 

>From ac88ba1883fb7292993665dfc33f4ef22be2ff15 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Tue, 8 Aug 2017 11:08:08 +0200
Subject: [PATCH] MAINTAINERS: Update Cavium ThunderX2 entry

Add Robert Richter as the primary maintainer for this platform.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..d26629c2820b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3133,6 +3133,7 @@ S:	Maintained
 F:	drivers/iio/light/cm*
 
 CAVIUM THUNDERX2 ARM64 SOC
+M:	Robert Richter <rrichter@cavium.com>
 M:	Jayachandran C <jnair@caviumnetworks.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.11.0
