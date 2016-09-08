From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Sep 2016 12:24:44 -0700
Subject: [PATCH 1/7] clk: gxbb: expose USB clocks
In-Reply-To: <20160907212836.GC12510@codeaurora.org> (Stephen Boyd's message
 of "Wed, 7 Sep 2016 14:28:36 -0700")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-2-martin.blumenstingl@googlemail.com>
 <20160907212836.GC12510@codeaurora.org>
Message-ID: <m2eg4ujitf.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 09/04, Martin Blumenstingl wrote:
>> USB0_DDR_BRIDGE and USB1_DDR_BRIDGE1 are needed for the related
>> dwc2 usb controller. USB, USB0 and USB1 are needed for the PHYs.
>> Expose these clocks to DT and comment out in clk driver.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>
> Assuming authorship is resolved:
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

After some clarification from Jerome (Martin is the primary author),
I've applied this, with the SoB order swapped.

Kevin
