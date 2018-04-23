From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Apr 2018 09:41:05 -0700
Subject: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
In-Reply-To: <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
References: <20180408113647.13543-1-yixun.lan@amlogic.com>
 <7ho9if3wo3.fsf@baylibre.com>
 <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
Message-ID: <CAOi56cUwzrpA1AdRQE3gdW55my-_dqSNnwyEd4poUPjUkpaBag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 11:55 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 April 2018 at 19:58, Kevin Hilman <khilman@baylibre.com> wrote:
>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>
>>> From: Nan Li <nan.li@amlogic.com>
>>>
>>> The IP of eMMC controller in AXG is similiar to Meson-GX series.
>>> Here we add the initial support of the HS200 mode with
>>> clock running at 166MHz (to be safe), since we found some eMMC chip
>>> fail to run at 200MHz due to tunning phase error.
>>>
>>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>
>> Applied to v4.18/dt64
>>
>>> ---
>>> Hi Kevin
>>>   Please note this patch actually depend on the eMMC driver here [0].
>>>   Still a few problem to solve, to improve the tuning phase driver to make
>>> the clock running at 200MHz, and to further support the HS400 mode.
>>> Anyway, this patch itself is quite independent.
>>
>> The driver changes are queued for v4.18 also.  Good!
>
> Right, may I consider that as an ack? :-)

I thought it was already merged while I was OoO, so I didn't bother to
reply with an ack, but if it's not too late, then yes:

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
