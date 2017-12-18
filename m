From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 18 Dec 2017 11:00:41 +0200
Subject: [PATCH v2 1/4] dt-bindings: usb: add DT binding for RK3328 dwc3
 controller
In-Reply-To: <1863083.H0I2rMmhUr@phil>
References: <20171204094041.25439-1-heiko@sntech.de> <1863083.H0I2rMmhUr@phil>
Message-ID: <87fu88jtqe.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Heiko Stuebner <heiko@sntech.de> writes:

> Hi Greg, Felipe,
>
> Am Montag, 4. Dezember 2017, 10:40:38 CET schrieb Heiko Stuebner:
>> From: William Wu <william.wu@rock-chips.com>
>> 
>> Adds the device tree bindings description for RK3328 and
>> compatible USB DWC3 controller.
>> 
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> do you want to pick this patch with only the small dt-binding
> change or Ack it for me to pick up together with the actual
> devicetree changes in the other patches?

it seems best if you carry this one:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
