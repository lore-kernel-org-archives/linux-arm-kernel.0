From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 16:08:00 +0200
Subject: [PATCH v4 06/11] gpio: pxa: add irq base in platform data
In-Reply-To: <1361290948-16669-7-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5124D8C0.6070504@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/13 18:22, Haojian Zhuang wrote:
> Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
> without DT. So move them into machine driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
