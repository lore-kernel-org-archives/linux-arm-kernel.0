From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 28 Nov 2014 13:08:27 +0100
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_FHANDLE
In-Reply-To: <1417176414-21558-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1417176414-21558-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <547865BB.1010604@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.11.2014 um 13:06 schrieb Sjoerd Simons:
> CONFIG_FHANDLE is required by systemd, which is the default init system
> in more and more distributions. So lets enable it for Exynos as well
> (it's already enabled in multi_v7_defconfig)
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
