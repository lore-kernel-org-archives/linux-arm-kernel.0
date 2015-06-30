From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Jun 2015 09:32:54 +0900
Subject: [PATCH-V5 1/4] mfd: 88pm800: Add device tree support
In-Reply-To: <1435591877-18214-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-2-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPcTSVKYYL-kdzbeA7gXaLM5b83qQYVeGxQxH_0=h8+RAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-30 0:31 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> Add DT support to the 88pm800 driver, along with compatible
> field for it's sub-devices (rtc, onkey and regulator)
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
