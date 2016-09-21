From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 21 Sep 2016 09:45:09 +0200
Subject: [PATCH v6 2/4] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <alpine.DEB.2.20.1609202214460.5476@nanos>
References: <1474387259-18926-1-git-send-email-alexandre.torgue@st.com>
 <1474387259-18926-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609202214460.5476@nanos>
Message-ID: <f7875786-9b5e-075a-59c8-cd32fb1c4583@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 09/20/2016 10:16 PM, Thomas Gleixner wrote:
> Alexandre,
>
> On Tue, 20 Sep 2016, Alexandre TORGUE wrote:
>
>> The STM32 external interrupt controller consists of edge detectors that
>> generate interrupts requests or wake-up events.
>>
>> Each line can be independently configured as interrupt or wake-up source,
>> and triggers either on rising, falling or both edges. Each line can also
>> be masked independently.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> That all looks very reasonable now. The only remaining question is your SOB
> chain. Who is the author of these patches? You or Maxime? If it's Maxime,
> then the changelog misses a From: tag. If it's you then Maximes SOB is
> bogus.

Actually Maxime wrote the main part of this driver and sent version 1 
and 2 of the series. After Linus W. reviews, rework was required to use 
hierarchical domain. According to Maxime, I coded the rework (adaptation 
to hierarchical domain) and sent other version of the series.

Regards

Alex

>
> Thanks,
>
> 	tglx
>
>
