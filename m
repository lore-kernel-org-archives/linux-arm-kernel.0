From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 15 Oct 2012 16:14:27 +0000
Subject: [PATCH 15/25] powerpc/fsl_msi: add a const qualifier
In-Reply-To: <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708101268@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 4:13 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         arch/powerpc/sysdev/fsl_msi.c: In function 'fsl_of_msi_probe':
>         arch/powerpc/sysdev/fsl_msi.c:379:11: error: assignment discards 'const' qualifier from pointer target type [-Werror]
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
