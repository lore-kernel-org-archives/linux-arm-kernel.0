From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 14:22:47 +0900
Subject: [PATCH v2 04/13] iommu/rockchip: Fix error handling in probe
In-Reply-To: <20180116132540.18939-5-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-5-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5A=szLktgV9RrsON+K7y21suXf9KfBaSWc44DauKapbKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Add missing iommu_device_sysfs_remove in error path.
>
> Also adjust sequence of deinit functions in the remove.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
