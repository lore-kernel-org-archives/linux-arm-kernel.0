From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Mar 2014 19:05:59 +0530
Subject: [PATCH 0/4] ARM: davinci: remove da8xx_omapl_defconfig
In-Reply-To: <1393397333-31915-1-git-send-email-nsekhar@ti.com>
References: <1393397333-31915-1-git-send-email-nsekhar@ti.com>
Message-ID: <531879BF.4060406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 12:18 PM, Sekhar Nori wrote:
> This patch series enabled da830 and da850 to build
> with davinci_all_defconfig and removes da8xx_omapl_defconfig
> since it will not be required anymore.
> 
> Sekhar Nori (4):
>   ARM: davinci: enable da8xx build concurrently with older devices
>   ARM: davinci: add da8xx specific configs to davinci_all_defconfig
>   ARM: davinci: da8xx: fix multiple watchdog device registration
>   ARM: davinci: remove da8xx_omapl_defconfig

Queuing these for v3.15

Thanks,
Sekhar
