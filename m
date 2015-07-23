From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 23 Jul 2015 14:08:03 +0900
Subject: [PATCH 2/4] mfd: devicetree: bindings: Add clock subdevice node
 information
In-Reply-To: <1437476823-3358-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPeUJ-7je67q+9X1_FcFiczoQ6rqwMAoPLswapFEmqGGVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-21 20:07 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> This patch updates the binding documentation for optional
> clocks node and related information for buffered 32KHz clock.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/88pm800.txt | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

+Cc Stephen Boyd (clocks)

We had a discussion whether clock bindings should be put in MFD
bindings documentation or into separate file in bindings/clock but
either way is fine for me:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
