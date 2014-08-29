From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 29 Aug 2014 20:08:33 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <1965890.bT7bZyQJt8@amdc1032>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <1965890.bT7bZyQJt8@amdc1032>
Message-ID: <2122329.o66gXAWddB@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 29, 2014 08:05:49 PM Bartlomiej Zolnierkiewicz wrote:

> +CONFIG_VIDEO_RENESAS_VSP1=y
> 
> This seems to be another option for Renesas specific hardware and it has
> a footprint of 23kB.

s/23/38/

[ sorry for the mistake ]

> [ I think that this option should depend on ARCH_SHMOBILE. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
