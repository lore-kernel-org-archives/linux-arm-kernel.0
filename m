From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 11 Jul 2015 15:54:33 +0900
Subject: [PATCH 1/6] mfd: 88pm80x: Add 88pm860 chip type support
In-Reply-To: <1436442431-3471-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-2-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55A0BDA9.1090409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
> Add chip identification support for 88PM860 device
> to the pm80x_chip_mapping table.
> 
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm80x.c       | 2 ++
>  include/linux/mfd/88pm80x.h | 1 +
>  2 files changed, 3 insertions(+)

FWIW:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
