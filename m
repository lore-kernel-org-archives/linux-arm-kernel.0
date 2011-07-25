From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 25 Jul 2011 18:49:31 +0530
Subject: [PATCH v2 3/6] arm: davinci: mmc: Add support for set_power
	callback
In-Reply-To: <1310303679-17936-4-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-4-git-send-email-ido@wizery.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE0A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 18:44:36, Ido Yariv wrote:
> Some devices connected to the MMC bus are power controlled by external
> means. For instance, an SDIO device may be powered down/up by an
> external gpio line.
> 
> In order to avoid toggling power from within the MMC host driver, add a
> set_power callback function, which will be called by set_ios upon
> powering down/up.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---
>  arch/arm/mach-davinci/include/mach/mmc.h |    3 +++
>  drivers/mmc/host/davinci_mmc.c           |   13 +++++++++++++

>  2 files changed, 16 insertions(+), 0 deletions(-)


This looks good to me, but needs Ack/Sign-off from
MMC maintainer. Please repost keeping him in CC.

Thanks,
Sekhar
