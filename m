From: cjb@laptop.org (Chris Ball)
Date: Tue, 26 Nov 2013 16:39:43 -0500
Subject: [PATCH 0/2] mmc: sdhci-esdhc-imx: adding eMMC HS200 mode support
In-Reply-To: <1383142242-24989-1-git-send-email-b29396@freescale.com> (Dong
 Aisheng's message of "Wed, 30 Oct 2013 22:10:40 +0800")
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Message-ID: <87ob56g7vk.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Wed, Oct 30 2013, Dong Aisheng wrote:
> Dong Aisheng (2):
>   mmc: sdhci: replace msleep with mdelay for tuning
>   mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
>
>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
>  drivers/mmc/host/sdhci.c           |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)

Patch 1 is no longer required, applied patch 2 to mmc-next for 3.14,
thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
