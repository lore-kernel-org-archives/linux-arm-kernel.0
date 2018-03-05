From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 5 Mar 2018 22:30:22 +0900
Subject: [RESEND PATCH v6 03/14] iommu/rockchip: Request irqs in
 rk_iommu_probe()
In-Reply-To: <20180301101837.27969-4-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-4-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5DLJwjdream_T4910L9qWbV1n5wivnn3xDCNFFuYqauVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On Thu, Mar 1, 2018 at 7:18 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Move request_irq to the end of rk_iommu_probe().
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> Loop platform_get_irq() as Robin suggested.
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
