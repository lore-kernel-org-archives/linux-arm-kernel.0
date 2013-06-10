From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 10 Jun 2013 09:40:35 -0700
Subject: [PATCH v3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
In-Reply-To: <51B59AC3.2080900@ti.com> (Benoit Cousson's message of "Mon, 10
 Jun 2013 11:22:11 +0200")
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
 <1370629886-14170-1-git-send-email-khilman@linaro.org>
 <20130607193130.GA13205@kahuna> <51B59AC3.2080900@ti.com>
Message-ID: <87fvwpex6k.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 06/07/2013 09:31 PM, Nishanth Menon wrote:
>> On 11:31-20130607, Kevin Hilman wrote:
>>> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
>>> SYS_NIRQ line on OMAP.  Add another DTS include file
>>> (twl4030_omap3.dtsi) for boards that hook up the twl4030 this way
>>> to include.
>>>
>>> This allows RTC wake from off-mode to work again on OMAP3-based
>>> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
>>> 3530/Overo, 3730/Overo-STORM.
>>>
>>> Special thanks to Florian Vaussard for suggesting use of preprocessor
>>> feature.
>>>
>>> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> Thanks,
>> Reviewed-by: Nishanth Menon <nm@ti.com>
>
> Thanks, I've just applied it in for_3.11/dts.

Thanks,

Will you apply the first 2 from the series too?

  ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
  ARM: DTS: OMAP3: beagle: enable user button via gpio_keys, enable wakeup

Thanks,

Kevin
