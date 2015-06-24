From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:53:03 +0100
Subject: [PATCH v6 2/9] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <272462057.251967.1435090588801.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014518-26223-1-git-send-email-srinivas.kandagatla@linaro.org>
 <272462057.251967.1435090588801.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7DFF.8020200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 21:16, Stefan Wahren wrote:
>> +
>> >+struct device;
> Do we need forward declaration of struct device_node too?
>
Yep, Will fix it in next version.
--srini
>> >+/* consumer cookie */
>> >[...]
