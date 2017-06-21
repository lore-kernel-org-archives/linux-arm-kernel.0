From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 21 Jun 2017 13:44:53 -0700
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for Broadcom STB DRAM
 Sensors
In-Reply-To: <CANEuBv6YEoTBBzPA5fkrveD05RZNtTBTak-qmxz7BvnrED5pbg@mail.gmail.com>
References: <20170613223710.31719-1-code@mmayer.net>
 <20170613223710.31719-2-code@mmayer.net>
 <20170618140529.wtqffjuilrkarzvd@rob-hp-laptop>
 <CANEuBv6YEoTBBzPA5fkrveD05RZNtTBTak-qmxz7BvnrED5pbg@mail.gmail.com>
Message-ID: <7128c063-1b3d-9cfb-71c6-f4590dac5e09@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2017 10:26 AM, Markus Mayer wrote:
> On 18 June 2017 at 07:05, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Jun 13, 2017 at 03:37:09PM -0700, Markus Mayer wrote:
>>> From: Markus Mayer <mmayer@broadcom.com>
>>>
>>> Provide bindings for the Broadcom STB DDR PHY Front End (DPFE).
>>>
>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>> ---
>>>  .../devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt  | 27 ++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Thanks, Rob.
> 
> To bring up the previous discussion regarding enumerating multiple
> nodes (so far we need two dpfe nodes for some platforms), how should
> we go about this? We were originally proposing to use "cell-index",
> but you said this was OpenFirmware only and couldn't be used in device
> tree. See https://lkml.org/lkml/2017/4/27/574.
> 
> We do need to use something, because the driver needs to know if it
> should be accessing dpfe0 or dpfe1. What should we use?

Would aliases work for instance for that purpose?
-- 
Florian
