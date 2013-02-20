From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 16:17:46 +0200
Subject: [PATCH v4 09/11] gpio: pxa: move gpio properties into child node
In-Reply-To: <1361290948-16669-10-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5124DB0A.50901@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/13 18:22, Haojian Zhuang wrote:
> Move gpio properties into child node. So pinctrl driver could binds to
> each gpio chip with gpio range.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

non-DT:
Tested-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
