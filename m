From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sun, 12 Aug 2018 11:43:17 +0200
Subject: [PATCH RESEND v3] arm64: clean the additional checks before
 calling ghes_notify_sea()
In-Reply-To: <20180811043547.560-1-gengdongjiu@huawei.com>
References: <20180811043547.560-1-gengdongjiu@huawei.com>
Message-ID: <CAJZ5v0j=2-h8YggK8w6qjn9qKrDX8jAJ87Axox8LBdnn95Xkvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 6:36 AM Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In order to remove the additional check before calling the
> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>
> After this cleanup, we can simply call the ghes_notify_sea() to let
> APEI driver handle the SEA notification.
>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> CC: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> ---
> This cleanup is ever mentioned by Mark Rutland in [1]
>
> [1]:
> https://lkml.org/lkml/2018/5/31/289
>
> change since v2:
> 1. Add 'Reviewed-by' of Tyler

I have applied the v2 already.

Thanks!
