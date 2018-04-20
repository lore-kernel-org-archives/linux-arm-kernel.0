From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 20 Apr 2018 08:55:47 +0200
Subject: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
In-Reply-To: <7ho9if3wo3.fsf@baylibre.com>
References: <20180408113647.13543-1-yixun.lan@amlogic.com>
 <7ho9if3wo3.fsf@baylibre.com>
Message-ID: <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2018 at 19:58, Kevin Hilman <khilman@baylibre.com> wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
>
>> From: Nan Li <nan.li@amlogic.com>
>>
>> The IP of eMMC controller in AXG is similiar to Meson-GX series.
>> Here we add the initial support of the HS200 mode with
>> clock running at 166MHz (to be safe), since we found some eMMC chip
>> fail to run at 200MHz due to tunning phase error.
>>
>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>
> Applied to v4.18/dt64
>
>> ---
>> Hi Kevin
>>   Please note this patch actually depend on the eMMC driver here [0].
>>   Still a few problem to solve, to improve the tuning phase driver to make
>> the clock running at 200MHz, and to further support the HS400 mode.
>> Anyway, this patch itself is quite independent.
>
> The driver changes are queued for v4.18 also.  Good!

Right, may I consider that as an ack? :-)

Kind regards
Uffe

>
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
