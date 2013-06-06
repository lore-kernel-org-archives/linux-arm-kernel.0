From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 6 Jun 2013 23:35:07 +0300
Subject: [PATCH v2 4/8] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <201306062111.06694.heiko@sntech.de>
References: <201306062107.58875.heiko@sntech.de>
 <201306062111.06694.heiko@sntech.de>
Message-ID: <CAHp75VdTYuXBu0Xu_BKZiBW9afjYprMBtBhSnNYjws-7b6hYmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 10:11 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
>
> There also seem to be no other modifications (additional register etc)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.

My comments against v1 of this patch are still valid.

--
With Best Regards,
Andy Shevchenko
