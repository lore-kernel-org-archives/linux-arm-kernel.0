From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Jun 2015 09:29:26 +0900
Subject: [PATCH-V5 3/4] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <1435591877-18214-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPd0raMXohsBK8rB8VsRt0kDTD9es6MAjHLKCqYyCAZC1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-30 0:31 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
> (page 0) controls the method of clearing interrupt
> status of 88pm800 family of devices;
>
>   0: clear on read
>   1: clear on write
>
> If pdata is not coming from board file, then set the
> default irq clear method to "irq clear on write"
>
> Also, as suggested by "Lee Jones" renaming variable field
> to appropriate name.
>
> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c       | 15 ++++++++++-----
>  include/linux/mfd/88pm80x.h | 10 ++++++++--
>  2 files changed, 18 insertions(+), 7 deletions(-)
>

Looks fine to me.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
