From: per.forlin@linaro.org (Per Forlin)
Date: Sun, 3 Jul 2011 22:53:45 +0200
Subject: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
In-Reply-To: <201107022137.30138.arnd@arndb.de>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<201107011844.44058.arnd@arndb.de>
	<20110702122938.GI21898@n2100.arm.linux.org.uk>
	<201107022137.30138.arnd@arndb.de>
Message-ID: <CAJ0pr1_Rd754qJ+jP9rqbez-9NAOwbxorziQrGDA0yrSMpPsxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 July 2011 21:37, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 02 July 2011 14:29:38 Russell King - ARM Linux wrote:
>> One other thing to be considered here is whether this idea should be
>> limited to just MMC or whether it should be extended further, to
>> move the DMA mapping stuff out of the hot path for other block devices
>> too.
>>
>> There are ARM systems with SATA which do 28MB/s - which could be
>> improved by this technique.
>
> Excellent point. We had discussed SATA items in the context of Linaro
> work before, and the conclusion was always that we wouldn't need to
> do any work for it in the common code. I'll make sure that we bring
> it up at the meeting next month in Cambridge so we can officially
> assign someone to do this.
>
Arnd, do you know if any of the Linaro boards have SATA?

Regards,
Per
