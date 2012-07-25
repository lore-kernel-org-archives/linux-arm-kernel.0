From: dirk.behme@googlemail.com (Dirk Behme)
Date: Wed, 25 Jul 2012 16:51:12 +0200
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <CAOMZO5A8J55WfXfzQNnvmDns558yZE16Ji+jmKuos+EK8JfXpQ@mail.gmail.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <CAOMZO5A8J55WfXfzQNnvmDns558yZE16Ji+jmKuos+EK8JfXpQ@mail.gmail.com>
Message-ID: <501007E0.1090005@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.07.2012 16:12, Fabio Estevam wrote:
> On Wed, Jul 25, 2012 at 9:37 AM, Dirk Behme<dirk.behme@de.bosch.com>  wrote:
>> From: Matthias Thomae<matthias.thomae@de.bosch.com>
>>
>> Set ARCH_NR_GPIO for the i.MX6 processor family, which has 7 GPIO
>> controllers with 32 signals each. The default of 256 GPIOs wastes
>> some static table space as explained in Documentation/gpio.txt.
>>
>> Signed-off-by: Matthias Thomae<matthias.thomae@de.bosch.com>
>
> Looks like a typo in the subject. It should be 224, right?

Yes.

Any further comments to be fixed in v2?

Best regards

Dirk
