From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Jun 2015 09:34:21 +0900
Subject: [PATCH-V5 2/4] mfd: 88pm800: Remove unnecessary protection around
 pdata
In-Reply-To: <1435591877-18214-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPduM_7vjiyFOtzqDyULSgk+ZG3rnn5qmm+ON+-uTJs_HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-30 0:31 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> With addition of proper checks in place in pm800_probe function,
> which makes sure that pdata would never become NULL.
> So remove all unnecessary protection around pdata in whole
> driver code.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
