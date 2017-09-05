From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 Sep 2017 08:37:11 +0100
Subject: [PATCH v3 5/5] mfd: mt6397: Add PMIC keys support to MT6397 driver
In-Reply-To: <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <1503642753-12385-6-git-send-email-chen.zhong@mediatek.com>
Message-ID: <20170905073711.vj75nniqg2ajkoeg@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Aug 2017, Chen Zhong wrote:

> This patch adds compatible strings and interrupts for pmic keys
> which serves as child device of MFD.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
