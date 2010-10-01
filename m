From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Oct 2010 16:19:47 -0700
Subject: [PATCH] omap3: Add minimal OMAP3 IGEP module support.
In-Reply-To: <1285971985-5662-1-git-send-email-eballetbo@gmail.com>
References: <1285971985-5662-1-git-send-email-eballetbo@gmail.com>
Message-ID: <20101001231947.GJ3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101001 15:18]:
> The OMAP3 IGEP module is a low-power, high performance production-ready
> system-on-module (SOM) based on TI's OMAP3 family.

Looks OK to me, but also looks like you're missing the uncompress.h
DEBUG_LL/EARLY_PRINTK entry?

Regards,

Tony
