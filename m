From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 16:36:01 -0700
Subject: [PATCH v3] arm: omap4: hsmmc: check for null pointer
In-Reply-To: <1335355066-26279-1-git-send-email-balajitk@ti.com>
References: <20120423144348.GF26302@arwen.pp.htv.fi>
 <1335355066-26279-1-git-send-email-balajitk@ti.com>
Message-ID: <20120508233600.GU5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Balaji T K <balajitk@ti.com> [120425 04:57]:
> platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
> Add check for NULL pointer. while at it move the duplicated functions
> to omap4-common.c
> 
> Fixes the following boot crash seen with omap4sdp and omap4panda
> when MMC is disabled.

Thanks applying into fixes-non-critical, this is a bit too intrusive for
the -rc series.

Regards,

Tony
