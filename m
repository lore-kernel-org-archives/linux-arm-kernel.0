From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 13 Jul 2015 20:24:02 +0100
Subject: [PATCH v7 2/9] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <1510509759.163664.1436814382477.JavaMail.open-xchange@oxbsltgw06.schlund.de>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521495-10728-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1510509759.163664.1436814382477.JavaMail.open-xchange@oxbsltgw06.schlund.de>
Message-ID: <55A41052.3000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/15 20:06, Stefan Wahren wrote:
>> -#include <linux/nvmem-provider.h>
>> >#include <linux/export.h>
>> >#include <linux/fs.h>
>> >#include <linux/idr.h>
>> >#include <linux/init.h>
>> >-#include <linux/regmap.h>
> please avoid such changes in your patch series. This should be fixed in the
> first patch.
Sure, I know why this happened, the headers were re-ordered in this 
patch.. I will take care of it.

--srini
