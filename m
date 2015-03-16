From: joe@perches.com (Joe Perches)
Date: Mon, 16 Mar 2015 12:06:20 -0700
Subject: [PATCH v6 3/4] MAINTAINERS: Add myself as maintainer of
 Allwinner Security System
In-Reply-To: <1426532482-28830-4-git-send-email-clabbe.montjoie@gmail.com>
References: <1426532482-28830-1-git-send-email-clabbe.montjoie@gmail.com>
 <1426532482-28830-4-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1426532780.23897.30.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-16 at 20:01 +0100, LABBE Corentin wrote:
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -10923,6 +10923,12 @@ L:	linux-mm at kvack.org
>  S:	Maintained
>  F:	mm/zswap.c
>  
> +ALLWINNER SECURITY SYSTEM
> +M:	Corentin Labbe <clabbe.montjoie@gmail.com>
> +L:	linux-crypto at vger.kernel.org
> +S:	Maintained
> +F:	drivers/crypto/sunxi-ss/

Use alphabetic ordering for new sections please.

Please place this section between:

ALI1563 I2C DRIVER
and
ALPHA PORT
