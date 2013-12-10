From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:56:52 +0000
Subject: [TRIVIAL PATCH 1/2] regulator: s5m8767: Define symbol for buck
 control mask
In-Reply-To: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
References: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131210095652.GX12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Krzysztof Kozlowski wrote:

> Replace hard-coded value for mask used in BUCKX_CTRL registers (for
> BUCKX_EN field) with a symbol. This also removes two local variables.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/s5m8767.c         |   11 ++++++-----
>  include/linux/mfd/samsung/s5m8767.h |    3 ++-
>  2 files changed, 8 insertions(+), 6 deletions(-)

For the MFD part:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
