From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 10:18:23 +0200
Subject: [PATCH v4 04/11] gpio: pxa: remove gpio_type
In-Reply-To: <1361290948-16669-5-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <512486CF.8070208@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/13 18:22, Haojian Zhuang wrote:
> Since gpio_type is used to check whether gafr register is valid. So
> move it into platform data.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
