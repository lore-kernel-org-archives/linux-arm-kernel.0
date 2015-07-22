From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 22 Jul 2015 08:26:36 +0100
Subject: [PATCH v8 2/9] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <1590184041.70825.1437495942088.JavaMail.open-xchange@oxbsltgw08.schlund.de>
References: <1437403352-4091-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1437403403-4180-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1590184041.70825.1437495942088.JavaMail.open-xchange@oxbsltgw08.schlund.de>
Message-ID: <55AF45AC.9040003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Stefan,

On 21/07/15 17:25, Stefan Wahren wrote:
>> +
>> >+ addr = of_get_property(cell_np, "reg", &len);
>> >+ if (!addr || (len < 2 * sizeof(int))) {
> I'm not sure, but shouldn't be sizeof(u32) more portable?
>
yes it makes sense, I will change it.
>> >[...]
>> >+
>> >+ addr = of_get_property(cell_np, "bits", &len);
>> >+ if (addr && len == (2 * sizeof(int))) {
> dito
yep.

--srini
