From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jun 2014 09:12:44 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers
In-Reply-To: <CAPDyKFr98GfBZuUbod+JnvbEEyDC+Unninetw=-=6o8muQw_NQ@mail.gmail.com>
References: <1402937442-7623-1-git-send-email-swarren@wwwdotorg.org>
 <CAPDyKFr98GfBZuUbod+JnvbEEyDC+Unninetw=-=6o8muQw_NQ@mail.gmail.com>
Message-ID: <7509698.bYIWhMVMID@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 June 2014 23:16:01 Ulf Hansson wrote:
> On 16 June 2014 18:50, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> >
> > Following 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> > SDHCI drivers that use MMC_SDHCI_PLTFM no longer select it, but
> > instead depend on it. This means that multi_v7_defconfig no longer
> > selects it, and hence many SDHCI drivers are no longer enabled.
> > Explicitly enable MMC_SDHCI_PLTFM to solve this.
> >
> > Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> I suppose this goes through arm-soc, otherwise ping me if you want me
> to handle it as a fix for 3.16.

I've added it to the fixes branch now, thanks!

	Arnd
