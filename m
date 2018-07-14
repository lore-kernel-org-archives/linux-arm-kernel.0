From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 14 Jul 2018 22:53:59 +0800
Subject: [PATCH 2/3] dt-bindings: pinctrl: meson-g12a: document pin name
In-Reply-To: <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <20180704224511.29350-3-yixun.lan@amlogic.com>
 <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
Message-ID: <84669bae-464b-a0ab-9050-cf4226d6b5de@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


HI Martin

thanks for the comments

On 07/14/2018 10:47 PM, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> On Wed, Jul 4, 2018 at 4:49 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> Document the pins for Amlogic's Meson-G12A SoC.
> I suggest to combine patch 1 (adding the compatible string) and 2 (this one)
> 
> as discussed in the cover letter: it would be great if you could add a
> comment (at least to the commit message) stating that GPIOE is
> actually located (checked with the ASIC / hardware team) in the AO
> bank
> 
sure, I will state this in commit message, and will also put a note in code.

>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> with that:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
thanks, I assume I can add your Ack to this whole patch series
(dt-binding patch and pinctrl driver patch)?

>> ---
>>  include/dt-bindings/gpio/meson-g12a-gpio.h | 114 +++++++++++++++++++++
>>  1 file changed, 114 insertions(+)
>>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>>
>> diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
>> new file mode 100644
>> index 000000000000..f7bd69350d18
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
>> @@ -0,0 +1,114 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>> +/*
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> (since I'm not sure about all the licensing bits:) do we also need a
> "Signed-off-by" from Xingyu Chen?
> 
sure, this pinctrl driver is mostly Xingyu's work, I will add this.
> 
> Regards
> Martin
> 
> .
> 
