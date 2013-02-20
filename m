From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 20 Feb 2013 16:02:51 +0200
Subject: [PATCH v4 05/11] gpio: pxa: define nr gpios in platform data
In-Reply-To: <1361290948-16669-6-git-send-email-haojian.zhuang@linaro.org>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <1361290948-16669-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5124D78B.9010702@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/13 18:22, Haojian Zhuang wrote:
> Avoid to identify gpio numbers in gpio driver. Identify it in platform data
> instead. So we can remove code of identifying cpu.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
