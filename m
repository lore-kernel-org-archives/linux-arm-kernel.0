From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Fri, 16 Jan 2015 20:53:16 +0800
Subject: [PATCH v5 2/5] Documentation: DT: Add bindings for Spreadtrum SoC
 Platform
In-Reply-To: <20150116102135.GC21809@leverpostej>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116102135.GC21809@leverpostej>
Message-ID: <CAAfSe-teDdPzRUnvzM+NErfZwmqM04yUMgic--hyZL8-Jjd8jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

>> +
>> +Required properties:
>> +- compatible: must be "sprd,sc9836-uart"
>> +- reg: offset and length of the register set for the device
>> +- interrupts: exactly one interrupt specifier
>> +- clocks: phandles to input clocks.
>
> The order and relevance of each should be specified. If you have
> multiple clocks I would strongly recommend you use clock-names to
> distinguish them.
>

Thank you for the recommendation.
but, since we haven't made the clock driver ready, for this initial
commit, we just let 4 UARTs share a single fixed 26 MHz clock source.
we'll do like you've recommended when we will submit the clock driver
in the future.

Best regards,
Chunyan



> Otherwise this looks fine.
>
> Mark.
>
