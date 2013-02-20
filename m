From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 16:26:58 +0200
Subject: [PATCH v4 10/11] gpio: pxa: bind to pinctrl by request
In-Reply-To: <1361290948-16669-11-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5124DD32.3080502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/13 18:22, Haojian Zhuang wrote:
> While gpio pins is requested, request the pin of pinctrl driver first.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

non-DT:
Tested-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
