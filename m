From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 18 Jan 2018 13:17:52 +0900
Subject: [PATCH v3 01/12] iommu/rockchip: Prohibiat unbind and remove
In-Reply-To: <20180117152542.26429-2-jeffy.chen@rock-chips.com>
References: <20180117152542.26429-1-jeffy.chen@rock-chips.com>
 <20180117152542.26429-2-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 12:25 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Removal the IOMMUs cannot be done reliably.

nit: Perhaps "Removal of IOMMUs"?

>
> This is similar to exynos iommu driver.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3:
> Also remove remove() and module_exit() as Tomasz suggested.
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

nit: Typo in subject: s/Prohibiat/Prohibit/

Otherwise,

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
