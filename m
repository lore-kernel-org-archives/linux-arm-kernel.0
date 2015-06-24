From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:51:51 +0100
Subject: [PATCH v6 4/9] nvmem: Add bindings for simple nvmem framework
In-Reply-To: <1670081084.252423.1435091735127.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014538-26308-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1670081084.252423.1435091735127.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7DB7.2040509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 21:35, Stefan Wahren wrote:
>> +Required properties:
>> >+reg: specifies the offset in byte within that storage device, start bit
>> >+ in the byte and the length in bits of the data we care about.
> Is the second parameter really in bits, not bytes?
Thanks for spotting this, I will fix this.
