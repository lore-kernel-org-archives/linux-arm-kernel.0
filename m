From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 27 Sep 2016 19:54:24 +0530
Subject: [PATCH 1/3] arm: dts: imx7: Update #pwm-cells for PWM polarity
 control
In-Reply-To: <20160923175202.GA2816@rob-hp-laptop>
References: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
 <20160919142347.11342-2-bhuvanchandra.dv@toradex.com>
 <20160923175202.GA2816@rob-hp-laptop>
Message-ID: <6739eff0-f6a7-7759-fe91-12790c5372f5@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/16 23:22, Rob Herring wrote:

> On Mon, Sep 19, 2016 at 07:53:45PM +0530, Bhuvanchandra DV wrote:
>> Update #pwm-cells to 3 in order to support PWM signal polarity control.
>>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 6 +++---
>>   arch/arm/boot/dts/imx7s.dtsi                      | 8 ++++----
>>   2 files changed, 7 insertions(+), 7 deletions(-)
> The driver will still work with old DTs, right? If so,

This patchset actually depends on the v6 patchset[1] from Lothar.
Some how that patchset got stalled in ML. I will re-spin the v6
patchset with the suggestions/changes from Lukasz in this patch[2]
after testing.

[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/294027.html
[2]https://www.spinics.net/lists/arm-kernel/msg530818.html

>
> Acked-by: Rob Herring <robh@kernel.org>
