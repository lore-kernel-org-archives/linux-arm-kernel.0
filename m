From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Fri, 11 Jun 2010 09:57:57 +0530
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <1276230477.7920.481.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-03 at 09:36 +0200, Eric Miao wrote:

(...)

> +
> +config ZRELADDR
> +       hex "Physical address of the decompressed kernel image"
> +       depends on !AUTO_ZRELADDR
> +       default 0x00008000 if ARCH_BCMRING || ARCH_CNS3XXX || ARCH_DOVE ||\
> +                             ARCH_EBSA110 || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR ||\
> +                             ARCH_IOP13XX || ARCH_IOP33X || ARCH_IXP2000 ||\
> +                             ARCH_IXP23XX || ARCH_IXP4XX || ARCH_KIRKWOOD ||\
> +                             ARCH_KS8695  || ARCH_LOKI || ARCH_MMP || ARCH_MV78XX0 ||\
> +                             ARCH_NOMADIK || ARCH_NUC93X || ARCH_NS9XXX ||\
> +                             ARCH_ORION5X || ARCH_SPEAR3XX || ARCH_SPEAR6XX ||\
> +                             ARCH_UX5XX || ARCH_VERSATILE || ARCH_W90X900

s/ARCH_UX5XX/ARCH_U8500

Srinidhi
