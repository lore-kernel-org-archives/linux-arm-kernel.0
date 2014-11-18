From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Nov 2014 11:46:45 +0000
Subject: [PATCH 2/7] mfd: MT6397: Add regmap for MT8135 and MT6397 SoC
In-Reply-To: <1416210027-5562-3-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
 <1416210027-5562-3-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141118114645.GX24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Flora Fu wrote:

> Add PMIC wrapper of MT8135 to access MFD MT6397.
> This is regmap of MT6397 MFD.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  drivers/mfd/Kconfig            |   8 +
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/mt8135-pmic-wrap.c | 847 +++++++++++++++++++++++++++++++++++++++++

All of the PMIC functionality needs removing from MFD and placed
somewhere else.  I suggest either drivers/power or drivers/regulator.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
